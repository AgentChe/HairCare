//
//  CatalogManager.swift
//  ScinCare
//
//  Created by Андрей Чернышев on 22.10.2024.
//

import RxSwift
import RxCocoa

protocol CatalogManagerProtocol {
    func obtainRecipes(forceUpdate: Bool) -> Single<[Catalog]>
    func obtainInsights(forceUpdate: Bool) -> Single<[Catalog]>
    func obtainGlossaries(forceUpdate: Bool) -> Single<[Catalog]>
    func obtainProcedures(forceUpdate: Bool) -> Single<[Catalog]>
    func obtainDiseases(forceUpdate: Bool) -> Single<[Catalog]>
    func obtainRecipeDetails(id: String) -> Single<CatalogDetails?>
    func obtainInsightDetails(id: String) -> Single<CatalogDetails?>
    func obtainGlossaryDetails(id: String) -> Single<CatalogDetails?>
    func obtainProcedureDetails(id: String) -> Single<CatalogDetails?>
    func obtainDiseaseDetails(id: String) -> Single<CatalogDetails?>
    func saveRecipe(id: String) -> Single<Void>
    func saveInsight(id: String) -> Single<Void>
    func saveGlossary(id: String) -> Single<Void>
    func saveProcedure(id: String) -> Single<Void>
    func saveDisease(id: String) -> Single<Void>
    func unsaveRecipes(ids: [String]) -> Single<Void>
    func unsaveInsights(ids: [String]) -> Single<Void>
    func unsaveGlossaries(ids: [String]) -> Single<Void>
    func unsaveProcedures(ids: [String]) -> Single<Void>
    func unsaveDiseases(ids: [String]) -> Single<Void>
    func obtainBookmarksRecipes() -> Single<[Catalog]>
    func obtainBookmarksInsights() -> Single<[Catalog]>
    func obtainBookmarksGlossaries() -> Single<[Catalog]>
    func obtainBookmarksProcedures() -> Single<[Catalog]>
    func obtainBookmarksDiseases() -> Single<[Catalog]>
}

final class CatalogManager {
    enum Constants {
        static let recipesKey = "catalog_manager_recipes_key"
        static let insightsKey = "catalog_manager_insights_key"
        static let glossariesKey = "catalog_manager_glossaries_key"
        static let proceduresKey = "catalog_manager_procedures_key"
        static let diseasesKey = "catalog_manager_diseases_key"
    }
    
    private lazy var sessionManager = SessionManager()
    
    private lazy var restAPITransport = RestAPITransport()
}

// MARK: CatalogManagerProtocol
extension CatalogManager: CatalogManagerProtocol {
    func obtainRecipes(forceUpdate: Bool) -> Single<[Catalog]> {
        if forceUpdate {
            let anonymousId = sessionManager.anonymousId
            let internalId = sessionManager.internalId
            
            let request = GetRecipesRequest(
                anonymousId: anonymousId,
                internalId: (internalId == anonymousId) ? nil : internalId,
                search: nil
            )
            return loadCatalogs(request: request, mapper: .hair, storageKey: Constants.recipesKey)
        } else {
            return cachedCatalogs(storageKey: Constants.recipesKey)
        }
    }
    
    func obtainInsights(forceUpdate: Bool) -> Single<[Catalog]> {
        if forceUpdate {
            let anonymousId = sessionManager.anonymousId
            let internalId = sessionManager.internalId
            
            let request = GetInsightsRequest(
                anonymousId: anonymousId,
                internalId: (internalId == anonymousId) ? nil : internalId,
                search: nil
            )
            return loadCatalogs(request: request, mapper: .hair, storageKey: Constants.insightsKey)
        } else {
            return cachedCatalogs(storageKey: Constants.insightsKey)
        }
    }
    
    func obtainGlossaries(forceUpdate: Bool) -> Single<[Catalog]> {
        if forceUpdate {
            let request = GetGlossariesRequest(userToken: sessionManager.internalId, search: nil)
            return loadCatalogs(request: request, mapper: .dermatology, storageKey: Constants.glossariesKey)
        } else {
            return cachedCatalogs(storageKey: Constants.glossariesKey)
        }
    }
    
    func obtainProcedures(forceUpdate: Bool) -> Single<[Catalog]> {
        if forceUpdate {
            let request = GetProceduresRequest(userToken: sessionManager.internalId, search: nil)
            return loadCatalogs(request: request, mapper: .dermatology, storageKey: Constants.proceduresKey)
        } else {
            return cachedCatalogs(storageKey: Constants.proceduresKey)
        }
    }
    
    func obtainDiseases(forceUpdate: Bool) -> Single<[Catalog]> {
        if forceUpdate {
            let request = GetDiseasesRequest(userToken: sessionManager.internalId, search: nil)
            return loadCatalogs(request: request, mapper: .dermatology, storageKey: Constants.diseasesKey)
        } else {
            return cachedCatalogs(storageKey: Constants.diseasesKey)
        }
    }
    
    func obtainRecipeDetails(id: String) -> Single<CatalogDetails?> {
        let anonymousId = sessionManager.anonymousId
        let internalId = sessionManager.internalId
        
        let request = GetRecipeDetailsRequest(
            anonymousId: anonymousId,
            internalId: (internalId == anonymousId) ? nil : internalId,
            id: id
        )
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .map { CatalogDetails(response: $0, mapper: .hair) }
    }
    
    func obtainInsightDetails(id: String) -> Single<CatalogDetails?> {
        let anonymousId = sessionManager.anonymousId
        let internalId = sessionManager.internalId
        
        let request = GetInsightDetailsRequest(
            anonymousId: anonymousId,
            internalId: (internalId == anonymousId) ? nil : internalId,
            id: id
        )
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .map { CatalogDetails(response: $0, mapper: .hair) }
    }
    
    func obtainGlossaryDetails(id: String) -> Single<CatalogDetails?> {
        let request = GetGlossaryDetailsRequest(userToken: sessionManager.internalId, id: id)
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .map { CatalogDetails(response: $0, mapper: .dermatology) }
    }
    
    func obtainProcedureDetails(id: String) -> Single<CatalogDetails?> {
        let request = GetProcedureDetailsRequest(userToken: sessionManager.internalId, id: id)
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .map { CatalogDetails(response: $0, mapper: .dermatology) }
    }
    
    func obtainDiseaseDetails(id: String) -> Single<CatalogDetails?> {
        let request = GetDiseaseDetailsRequest(userToken: sessionManager.internalId, id: id)
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .map { CatalogDetails(response: $0, mapper: .dermatology) }
    }
    
    func saveRecipe(id: String) -> Single<Void> {
        let anonymousId = sessionManager.anonymousId
        let internalId = sessionManager.internalId
        
        let request = SaveRecipeRequest(
            anonymousId: anonymousId,
            internalId: (internalId == anonymousId) ? nil : internalId,
            id: id
        )
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .mapToVoid()
            .do(onSuccess: {
                CatalogMediator.shared.saveRecipe(id: id)
            })
    }
    
    func saveInsight(id: String) -> Single<Void> {
        let anonymousId = sessionManager.anonymousId
        let internalId = sessionManager.internalId
        
        let request = SaveInsightRequest(
            anonymousId: anonymousId,
            internalId: (internalId == anonymousId) ? nil : internalId,
            id: id
        )
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .mapToVoid()
            .do(onSuccess: {
                CatalogMediator.shared.saveInsight(id: id)
            })
    }
    
    func saveGlossary(id: String) -> Single<Void> {
        let request = SaveGlossaryRequest(userToken: sessionManager.internalId, id: id)
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .mapToVoid()
            .do(onSuccess: {
                CatalogMediator.shared.saveGlossary(id: id)
            })
    }
    
    func saveProcedure(id: String) -> Single<Void> {
        let request = SaveProcedureRequest(userToken: sessionManager.internalId, id: id)
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .mapToVoid()
            .do(onSuccess: {
                CatalogMediator.shared.saveProcedure(id: id)
            })
    }
    
    func saveDisease(id: String) -> Single<Void> {
        let request = SaveDiseaseRequest(userToken: sessionManager.internalId, id: id)
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .mapToVoid()
            .do(onSuccess: {
                CatalogMediator.shared.saveDisease(id: id)
            })
    }
    
    func unsaveRecipes(ids: [String]) -> Single<Void> {
        let anonymousId = sessionManager.anonymousId
        let internalId = sessionManager.internalId
        
        let request = UnsaveRecipeRequest(
            anonymousId: anonymousId,
            internalId: (internalId == anonymousId) ? nil : internalId,
            ids: ids
        )
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .mapToVoid()
            .do(onSuccess: {
                CatalogMediator.shared.unsaveRecipes(ids: ids)
            })
    }
    
    func unsaveInsights(ids: [String]) -> Single<Void> {
        let anonymousId = sessionManager.anonymousId
        let internalId = sessionManager.internalId
        
        let request = UnsaveInsightRequest(
            anonymousId: anonymousId,
            internalId: (internalId == anonymousId) ? nil : internalId,
            ids: ids
        )
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .mapToVoid()
            .do(onSuccess: {
                CatalogMediator.shared.unsaveInsights(ids: ids)
            })
    }
    
    func unsaveGlossaries(ids: [String]) -> Single<Void> {
        let request = UnsaveGlossaryRequest(userToken: sessionManager.internalId, ids: ids)
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .mapToVoid()
            .do(onSuccess: {
                CatalogMediator.shared.unsaveGlossaries(ids: ids)
            })
    }
    
    func unsaveProcedures(ids: [String]) -> Single<Void> {
        let request = UnsaveProcedureRequest(userToken: sessionManager.internalId, ids: ids)
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .mapToVoid()
            .do(onSuccess: {
                CatalogMediator.shared.unsaveProcedures(ids: ids)
            })
    }
    
    func unsaveDiseases(ids: [String]) -> Single<Void> {
        let request = UnsaveDiseaseRequest(userToken: sessionManager.internalId, ids: ids)
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .mapToVoid()
            .do(onSuccess: {
                CatalogMediator.shared.unsaveDiseases(ids: ids)
            })
    }
    
    func obtainBookmarksRecipes() -> Single<[Catalog]> {
        let anonymousId = sessionManager.anonymousId
        let internalId = sessionManager.internalId
        
        let request = GetBookmarksRecipesRequest(
            anonymousId: anonymousId,
            internalId: (internalId == anonymousId) ? nil : internalId
        )
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .map { Catalog.map(response: $0, mapper: .hair) }
    }
    
    func obtainBookmarksInsights() -> Single<[Catalog]> {
        let anonymousId = sessionManager.anonymousId
        let internalId = sessionManager.internalId
        
        let request = GetBookmarksInsightsRequest(
            anonymousId: anonymousId,
            internalId: (internalId == anonymousId) ? nil : internalId
        )
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .map { Catalog.map(response: $0, mapper: .hair) }
    }
    
    func obtainBookmarksGlossaries() -> Single<[Catalog]> {
        let request = GetBookmarksGlossariesRequest(userToken: sessionManager.internalId)
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .map { Catalog.map(response: $0, mapper: .dermatology) }
    }
    
    func obtainBookmarksProcedures() -> Single<[Catalog]> {
        let request = GetBookmarksProceduresRequest(userToken: sessionManager.internalId)
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .map { Catalog.map(response: $0, mapper: .dermatology) }
    }
    
    func obtainBookmarksDiseases() -> Single<[Catalog]> {
        let request = GetBookmarksDiseasesRequest(userToken: sessionManager.internalId)
        
        return restAPITransport
            .callServerApi(requestBody: request)
            .map { Catalog.map(response: $0, mapper: .dermatology) }
    }
}

// MARK: Private
private extension CatalogManager {
    func loadCatalogs(request: APIRequestBody, mapper: Catalog.Mapper, storageKey: String) -> Single<[Catalog]> {
        restAPITransport
            .callServerApi(requestBody: request)
            .map { Catalog.map(response: $0, mapper: mapper) }
            .do(onSuccess: { catalogs in
                guard let data = try? JSONEncoder().encode(catalogs) else { return }
                
                UserDefaults.standard.set(data, forKey: storageKey)
            })
    }
    
    func cachedCatalogs(storageKey: String) -> Single<[Catalog]> {
        Single<[Catalog]>.create { event in
            guard
                let data = UserDefaults.standard.data(forKey: storageKey),
                let catalogs = try? JSONDecoder().decode([Catalog].self, from: data)
            else {
                event(.success([]))
                return Disposables.create()
            }

            event(.success(catalogs))

            return Disposables.create()
        }
    }
}
