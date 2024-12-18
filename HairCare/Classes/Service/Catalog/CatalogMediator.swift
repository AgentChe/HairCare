//
//  CatalogMediator.swift
//  ScinCare
//
//  Created by Андрей Чернышев on 22.10.2024.
//

import RxSwift
import RxCocoa

final class CatalogMediator {
    static let shared = CatalogMediator()
    
    private lazy var didSaveRecipeIdTrigger = PublishRelay<String>()
    private lazy var didUnsaveRecipesIdsTrigger = PublishRelay<[String]>()
    private lazy var didSaveInsightIdTrigger = PublishRelay<String>()
    private lazy var didUnsaveInsightsIdsTrigger = PublishRelay<[String]>()
    private lazy var didSaveGlossaryIdTrigger = PublishRelay<String>()
    private lazy var didUnsaveGlossariesIdsTrigger = PublishRelay<[String]>()
    private lazy var didSaveProcedureIdTrigger = PublishRelay<String>()
    private lazy var didUnsaveProceduresIdsTrigger = PublishRelay<[String]>()
    private lazy var didSaveDiseaseIdTrigger = PublishRelay<String>()
    private lazy var didUnsaveDiseasesIdsTrigger = PublishRelay<[String]>()
    
    private init() {}
}

// MARK: Public
extension CatalogMediator {
    func saveRecipe(id: String) {
        DispatchQueue.main.async {
            Self.shared.didSaveRecipeIdTrigger.accept(id)
        }
    }
    
    func unsaveRecipes(ids: [String]) {
        DispatchQueue.main.async {
            Self.shared.didUnsaveRecipesIdsTrigger.accept(ids)
        }
    }
    
    func saveInsight(id: String) {
        DispatchQueue.main.async {
            Self.shared.didSaveInsightIdTrigger.accept(id)
        }
    }
    
    func unsaveInsights(ids: [String]) {
        DispatchQueue.main.async {
            Self.shared.didUnsaveInsightsIdsTrigger.accept(ids)
        }
    }
    
    func saveGlossary(id: String) {
        DispatchQueue.main.async {
            Self.shared.didSaveGlossaryIdTrigger.accept(id)
        }
    }
    
    func unsaveGlossaries(ids: [String]) {
        DispatchQueue.main.async {
            Self.shared.didUnsaveGlossariesIdsTrigger.accept(ids)
        }
    }
    
    func saveProcedure(id: String) {
        DispatchQueue.main.async {
            Self.shared.didSaveProcedureIdTrigger.accept(id)
        }
    }
    
    func unsaveProcedures(ids: [String]) {
        DispatchQueue.main.async {
            Self.shared.didUnsaveProceduresIdsTrigger.accept(ids)
        }
    }
    
    func saveDisease(id: String) {
        DispatchQueue.main.async {
            Self.shared.didSaveDiseaseIdTrigger.accept(id)
        }
    }
    
    func unsaveDiseases(ids: [String]) {
        DispatchQueue.main.async {
            Self.shared.didUnsaveDiseasesIdsTrigger.accept(ids)
        }
    }
    
    var didSaveRecipeId: Signal<String> {
        didSaveRecipeIdTrigger.asSignal()
    }
    
    var didUnsaveRecipesIds: Signal<[String]> {
        didUnsaveRecipesIdsTrigger.asSignal()
    }
    
    var didSaveInsightId: Signal<String> {
        didSaveInsightIdTrigger.asSignal()
    }
    
    var didUnsaveInsightsIds: Signal<[String]> {
        didUnsaveInsightsIdsTrigger.asSignal()
    }
    
    var didSaveGlossaryId: Signal<String> {
        didSaveGlossaryIdTrigger.asSignal()
    }
    
    var didUnsaveGlossariesIds: Signal<[String]> {
        didUnsaveGlossariesIdsTrigger.asSignal()
    }
    
    var didSaveProcedureId: Signal<String> {
        didSaveProcedureIdTrigger.asSignal()
    }
    
    var didUnsaveProceduresIds: Signal<[String]> {
        didUnsaveProceduresIdsTrigger.asSignal()
    }
    
    var didSaveDiseaseId: Signal<String> {
        didSaveDiseaseIdTrigger.asSignal()
    }
    
    var didUnsaveDiseasesIds: Signal<[String]> {
        didUnsaveDiseasesIdsTrigger.asSignal()
    }
}
