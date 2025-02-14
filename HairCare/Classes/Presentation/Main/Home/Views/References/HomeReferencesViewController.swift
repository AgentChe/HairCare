//
//  HomeReferencesViewController.swift
//  HairCare
//
//  Created by Андрей Чернышев on 14.02.2025.
//

import UIKit
import RxSwift

final class HomeReferencesViewController: UIViewController {
    private lazy var mainView = HomeReferencesView()
    
    private lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.direction = .down
        mainView.container.isUserInteractionEnabled = true
        mainView.container.addGestureRecognizer(swipeGesture)
        
        Observable
            .merge(
                mainView.button.rx.tap.asObservable(),
                swipeGesture.rx.event.mapToVoid()
            )
            .bind(to: Binder(self) { base, void in
                base.mainView.animateDismiss {
                    base.dismiss(animated: false)
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        mainView.animateShow()
    }
}

// MARK: Public
extension HomeReferencesViewController {
    static func make() -> HomeReferencesViewController {
        let vc = HomeReferencesViewController()
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
}
