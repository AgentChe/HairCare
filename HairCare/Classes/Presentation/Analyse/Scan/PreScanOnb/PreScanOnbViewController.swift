//
//  PreScanOnbViewController.swift
//  HairCare
//
//  Created by Андрей Чернышев on 24.01.2025.
//

import UIKit
import RxSwift

final class PreScanOnbViewController: UIViewController {
    private lazy var mainView = PreScanOnbView { [weak self] in
        self?.complete()
    }
    
    private lazy var disposeBag = DisposeBag()
    
    private let close: () -> Void
    private let complete: () -> Void
    
    private init(close: @escaping () -> Void, complete: @escaping () -> Void) {
        self.close = close
        self.complete = complete
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.closeButton.rx.tap
            .bind(to: Binder(self) { base, void in
                base.close()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Publc
extension PreScanOnbViewController {
    static func make(close: @escaping () -> Void, complete: @escaping () -> Void) -> PreScanOnbViewController {
        let vc = PreScanOnbViewController(close: close, complete: complete)
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}
