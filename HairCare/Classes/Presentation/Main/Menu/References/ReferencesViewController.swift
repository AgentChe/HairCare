//
//  ReferencesViewController.swift
//  HairCare
//
//  Created by Андрей Чернышев on 23.01.2025.
//

import UIKit
import RxSwift

final class ReferencesViewController: UIViewController {
    private lazy var mainView = ReferencesView()
    
    private lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backButton.rx.tap
            .bind(to: Binder(self) { base, void in
                base.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        Observable
            .merge(
                mainView.link1Button.rx.tap
                    .compactMap { URL(string: "https://www.nlm.nih.gov") },
                mainView.link2Button.rx.tap
                    .compactMap { URL(string: "https://www.cdc.gov/health-topics.html") }
            )
            .bind(to: Binder(self) { base, url in
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Public
extension ReferencesViewController {
    static func make() -> ReferencesViewController {
        ReferencesViewController()
    }
}
