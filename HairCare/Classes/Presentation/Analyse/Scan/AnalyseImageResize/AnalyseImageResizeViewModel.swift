//
//  AnalyseImageResizeViewModel.swift
//  ScinCare
//
//  Created by Андрей Чернышев on 31.10.2024.
//

import RxSwift
import RxCocoa

final class AnalyseImageResizeViewModel {
    enum Route {
        case back
        case retake
        case finish(AnalyseScanResult)
    }
    
    enum Action {
        case crop
        case changeOptionsState(AnalyseImageResizeOptionsView.State)
    }
    
    private lazy var analyseManager = AnalyseManager()
}

// MARK: Public
extension AnalyseImageResizeViewModel {
    struct Input {
        let didTapBack: Signal<Void>
        let didAcceptPhoto: Signal<Void>
        let didRetakePhoto: Signal<Void>
        let didContinue: Signal<Void>
        let pushCroppedImage: Signal<UIImage>
    }
    
    struct Output {
        let route: Driver<Route>
        let action: Driver<Action>
    }
    
    func configure(input: Input) -> Output {
        let scanResult = makeScanResult(pushCroppedImage: input.pushCroppedImage)
        let optionsState = makeOptionsState(
            pushCroppedImage: input.pushCroppedImage,
            scanResult: scanResult
        )
        
        return Output(
            route: makeRoute(
                didTapBack: input.didTapBack,
                didRetakePhoto: input.didRetakePhoto,
                didContinue: input.didContinue,
                scanResult: scanResult
            ),
            action: makeAction(
                didAcceptPhoto: input.didAcceptPhoto,
                optionsState: optionsState
            )
        )
    }
}

// MARK: Private
private extension AnalyseImageResizeViewModel {
    func makeRoute(
        didTapBack: Signal<Void>,
        didRetakePhoto: Signal<Void>,
        didContinue: Signal<Void>,
        scanResult: Driver<AnalyseScanResult?>
    ) -> Driver<Route> {
        let back = didTapBack
            .map { Route.back }
            .asDriver(onErrorDriveWith: .never())
        
        let retake = didRetakePhoto
            .map { Route.retake }
            .asDriver(onErrorDriveWith: .never())
        
        let finish = didContinue
            .withLatestFrom(scanResult)
            .compactMap { $0 }
            .map { Route.finish($0) }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver
            .merge(back, retake, finish)
    }
    
    func makeAction(
        didAcceptPhoto: Signal<Void>,
        optionsState: Driver<AnalyseImageResizeOptionsView.State>
    ) -> Driver<Action> {
        let crop = didAcceptPhoto
            .map { Action.crop }
            .asDriver(onErrorDriveWith: .never())
        
        let changedOptionsState = optionsState
            .map { Action.changeOptionsState($0) }
            .asDriver(onErrorDriveWith: .never())
        
        return Driver
            .merge(crop, changedOptionsState)
    }
    
    func makeOptionsState(
        pushCroppedImage: Signal<UIImage>,
        scanResult: Driver<AnalyseScanResult?>
    ) -> Driver<AnalyseImageResizeOptionsView.State> {
        let preloader = pushCroppedImage
            .asDriver(onErrorDriveWith: .never())
            .map { _ in AnalyseImageResizeOptionsView.State.preloader }
        
        let result = scanResult
            .map { $0 == nil ? AnalyseImageResizeOptionsView.State.incorrect : AnalyseImageResizeOptionsView.State.correct }
        
        return Driver
            .merge(preloader, result)
            .startWith(.acceptPhoto)
    }
    
    func makeScanResult(pushCroppedImage: Signal<UIImage>) -> Driver<AnalyseScanResult?> {
        pushCroppedImage
            .flatMapLatest { [weak self] image -> Driver<AnalyseScanResult?> in
                guard let self else { return .never() }
                
                return analyseManager
                    .analyseScan(image: image)
                    .asDriver(onErrorJustReturn: nil)
            }
    }
}
