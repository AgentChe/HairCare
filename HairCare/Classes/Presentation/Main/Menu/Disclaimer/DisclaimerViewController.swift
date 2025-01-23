//
//  DisclaimerViewController.swift
//  HairCare
//
//  Created by Андрей Чернышев on 23.01.2025.
//

import UIKit
import RxSwift

final class DisclaimerViewController: UIViewController {
    private lazy var mainView = DisclaimerView()
    
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
    }
}

// MARK: Public
extension DisclaimerViewController {
    static func make() -> DisclaimerViewController {
        DisclaimerViewController()
    }
}
