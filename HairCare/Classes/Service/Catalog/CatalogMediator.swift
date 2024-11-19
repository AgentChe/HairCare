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
    
    private lazy var didSaveRecipeIdTrigger = PublishRelay<Int>()
    private lazy var didUnsaveRecipesIdsTrigger = PublishRelay<[Int]>()
    private lazy var didSaveInsightIdTrigger = PublishRelay<Int>()
    private lazy var didUnsaveInsightsIdsTrigger = PublishRelay<[Int]>()
    private lazy var didSaveGlossaryIdTrigger = PublishRelay<Int>()
    private lazy var didUnsaveGlossariesIdsTrigger = PublishRelay<[Int]>()
    private lazy var didSaveProcedureIdTrigger = PublishRelay<Int>()
    private lazy var didUnsaveProceduresIdsTrigger = PublishRelay<[Int]>()
    private lazy var didSaveDiseaseIdTrigger = PublishRelay<Int>()
    private lazy var didUnsaveDiseasesIdsTrigger = PublishRelay<[Int]>()
    
    private init() {}
}

// MARK: Public
extension CatalogMediator {
    func saveRecipe(id: Int) {
        DispatchQueue.main.async {
            Self.shared.didSaveRecipeIdTrigger.accept(id)
        }
    }
    
    func unsaveRecipes(ids: [Int]) {
        DispatchQueue.main.async {
            Self.shared.didUnsaveRecipesIdsTrigger.accept(ids)
        }
    }
    
    func saveInsight(id: Int) {
        DispatchQueue.main.async {
            Self.shared.didSaveInsightIdTrigger.accept(id)
        }
    }
    
    func unsaveInsights(ids: [Int]) {
        DispatchQueue.main.async {
            Self.shared.didUnsaveInsightsIdsTrigger.accept(ids)
        }
    }
    
    func saveGlossary(id: Int) {
        DispatchQueue.main.async {
            Self.shared.didSaveGlossaryIdTrigger.accept(id)
        }
    }
    
    func unsaveGlossaries(ids: [Int]) {
        DispatchQueue.main.async {
            Self.shared.didUnsaveGlossariesIdsTrigger.accept(ids)
        }
    }
    
    func saveProcedure(id: Int) {
        DispatchQueue.main.async {
            Self.shared.didSaveProcedureIdTrigger.accept(id)
        }
    }
    
    func unsaveProcedures(ids: [Int]) {
        DispatchQueue.main.async {
            Self.shared.didUnsaveProceduresIdsTrigger.accept(ids)
        }
    }
    
    func saveDisease(id: Int) {
        DispatchQueue.main.async {
            Self.shared.didSaveDiseaseIdTrigger.accept(id)
        }
    }
    
    func unsaveDiseases(ids: [Int]) {
        DispatchQueue.main.async {
            Self.shared.didUnsaveDiseasesIdsTrigger.accept(ids)
        }
    }
    
    var didSaveRecipeId: Signal<Int> {
        didSaveRecipeIdTrigger.asSignal()
    }
    
    var didUnsaveRecipesIds: Signal<[Int]> {
        didUnsaveRecipesIdsTrigger.asSignal()
    }
    
    var didSaveInsightId: Signal<Int> {
        didSaveInsightIdTrigger.asSignal()
    }
    
    var didUnsaveInsightsIds: Signal<[Int]> {
        didUnsaveInsightsIdsTrigger.asSignal()
    }
    
    var didSaveGlossaryId: Signal<Int> {
        didSaveGlossaryIdTrigger.asSignal()
    }
    
    var didUnsaveGlossariesIds: Signal<[Int]> {
        didUnsaveGlossariesIdsTrigger.asSignal()
    }
    
    var didSaveProcedureId: Signal<Int> {
        didSaveProcedureIdTrigger.asSignal()
    }
    
    var didUnsaveProceduresIds: Signal<[Int]> {
        didUnsaveProceduresIdsTrigger.asSignal()
    }
    
    var didSaveDiseaseId: Signal<Int> {
        didSaveDiseaseIdTrigger.asSignal()
    }
    
    var didUnsaveDiseasesIds: Signal<[Int]> {
        didUnsaveDiseasesIdsTrigger.asSignal()
    }
}
