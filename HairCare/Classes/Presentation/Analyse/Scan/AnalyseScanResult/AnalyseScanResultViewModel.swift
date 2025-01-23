//
//  AnalyseScanResultViewModel.swift
//  ScinCare
//
//  Created by Андрей Чернышев on 01.11.2024.
//

import RxSwift
import RxCocoa

final class AnalyseScanResultViewModel {
    enum Route {
        case close
        case disclaimer
        case references
        case save(AnalyseScanResultViewController.SaveData)
        case setNotification(String)
    }
    
    var tryAgain: ((Error) -> (Observable<Void>))?
    
    private let source: Driver<Source>
    
    init(resultFromScan: AnalyseScanResult) {
        source = BehaviorRelay(value: .resultFromScan(resultFromScan)).asDriver()
    }
    
    init(analyseId: String) {
        source = BehaviorRelay(value: .byAnalyseId(analyseId)).asDriver()
    }
    
    private lazy var activity = RxActivityIndicator()
    
    private lazy var analyseManager = AnalyseManager()
    
    private lazy var observableRetrySingle = ObservableRetrySingle()
}

// MARK: Public
extension AnalyseScanResultViewModel {
    struct Input {
        let didTapClose: Signal<Void>
        let didTapDisclaimer: Signal<Void>
        let didTapReferences: Signal<Void>
        let didTapAction: Signal<Void>
    }
    
    struct Output {
        let activity: Driver<Bool>
        let actionButtonState: Driver<AnalyseScanResultView.ActionButton>
        let elements: Driver<[AnalyseScanResultTableElement]>
        let route: Driver<Route>
    }
    
    func configure(input: Input) -> Output {
        let scanResult = makeScanResult(source: source)
        let actionButtonState = makeActionButtonState(scanResult: scanResult)
        
        return Output(
            activity: activity.asDriver(),
            actionButtonState: actionButtonState,
            elements: makeElements(scanResult: scanResult),
            route: makeRoute(
                didTapClose: input.didTapClose,
                didTapDisclaimer: input.didTapDisclaimer,
                didTapReferences: input.didTapReferences,
                didTapAction: input.didTapAction,
                scanResult: scanResult,
                actionButtonState: actionButtonState
            )
        )
    }
}

// MARK: Private
private extension AnalyseScanResultViewModel {
    enum Source {
        case resultFromScan(AnalyseScanResult)
        case byAnalyseId(String)
    }
    
    func makeElements(scanResult: Driver<AnalyseScanResult>) -> Driver<[AnalyseScanResultTableElement]> {
        scanResult
            .map { scanResult -> [AnalyseScanResultTableElement] in
                var result: [AnalyseScanResultTableElement] = [
                    .image(scanResult.image),
                    .name(scanResult.name),
                ]
                
                if let assessment = scanResult.assessment {
                    result.append(.assessment(assessment))
                }
                if let conclusion = scanResult.conclusion {
                    result.append(.conclusion(conclusion))
                }
                if let recommendations = scanResult.recommendations {
                    result.append(.recommendations(recommendations))
                }
                if let description = scanResult.description {
                    result.append(.description(description))
                }
                
                result.append(.disclaimer)
                
                return result
            }
    }
    
    func makeActionButtonState(scanResult: Driver<AnalyseScanResult>) -> Driver<AnalyseScanResultView.ActionButton> {
        scanResult
            .map { $0.saved ? .setNotifications : .save }
    }
    
    func makeScanResult(source: Driver<Source>) -> Driver<AnalyseScanResult> {
        source
            .flatMapLatest { [weak self] dataSource -> Driver<AnalyseScanResult> in
                guard let self else { return .never() }
                
                func source() -> Single<AnalyseScanResult> {
                    let scanResult: Single<AnalyseScanResult?> = {
                        switch dataSource {
                        case .resultFromScan(let resultFromScan):
                            return .just(resultFromScan)
                        case .byAnalyseId(let analyseId):
                            return self.analyseManager
                                .getAnalyseResult(analyseId: analyseId)
                        }
                    }()
                    
                    return scanResult
                        .map { result -> AnalyseScanResult in
                            guard let result else {
                                throw ContentError(.notContent)
                            }
                            
                            return result
                        }
                }
                
                func trigger(error: Error) -> Observable<Void> {
                    guard let tryAgain = self.tryAgain?(error) else {
                        return .empty()
                    }
                    
                    return tryAgain
                }
                
                return observableRetrySingle
                    .retry(
                        source: { source() },
                        trigger: { trigger(error: $0) }
                    )
                    .trackActivity(activity)
                    .asDriver(onErrorDriveWith: .never())
            }
    }
    
    func makeRoute(
        didTapClose: Signal<Void>,
        didTapDisclaimer: Signal<Void>,
        didTapReferences: Signal<Void>,
        didTapAction: Signal<Void>,
        scanResult: Driver<AnalyseScanResult>,
        actionButtonState: Driver<AnalyseScanResultView.ActionButton>
    ) -> Driver<Route> {
        let close = didTapClose
            .map { Route.close }
            .asDriver(onErrorDriveWith: .never())
        
        let disclaimer = didTapDisclaimer
            .map { Route.disclaimer }
            .asDriver(onErrorDriveWith: .never())
        
        let references = didTapReferences
            .map { Route.references }
            .asDriver(onErrorDriveWith: .never())
        
        let action = didTapAction
            .asDriver(onErrorDriveWith: .never())
            .withLatestFrom(scanResult)
            .withLatestFrom(actionButtonState) { ($0, $1) }
            .map { args -> Route in
                let (scanResult, actionButtonState) = args
                return {
                    switch actionButtonState {
                    case .save:
                        let saveData = AnalyseScanResultViewController.SaveData(
                            analyseId: scanResult.id,
                            image: scanResult.image
                        )
                        return Route.save(saveData)
                    case .setNotifications:
                        return Route.setNotification(scanResult.id)
                    }
                }()
            }
        
        return Driver
            .merge(close, disclaimer, references, action)
    }
}
