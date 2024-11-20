//
//  AnalyseScanResultAssembly.swift
//  ScinCare
//
//  Created by Андрей Чернышев on 03.11.2024.
//

import UIKit

final class AnalyseScanResultAssembly {
    func open(with analyseId: String, from: UIViewController) {
        let nc = NavigationController()
        nc.modalPresentationStyle = .fullScreen
        
        let scanResultVC = AnalyseScanResultViewController.make(analyseId: analyseId) { [weak nc] result in
            switch result {
            case .close:
                nc?.dismiss(animated: true)
            case .save(let saveData):
                let input = SaveAnalyseSetTitleViewController.Input(
                    analyseId: saveData.analyseId,
                    image: saveData.image
                )
                
                let setTitleVC = SaveAnalyseSetTitleViewController.make(input: input) { [weak nc] result in
                    switch result {
                    case .back:
                        nc?.popViewController(animated: true)
                    case .complete:
                        let resultVC = SaveAnalyseCompleteViewController.make { vc, result in
                            switch result {
                            case .setNotification:
                                CreateReminderAssembly().create(from: vc)
                            case .later:
                                nc?.dismiss(animated: true)
                            }
                        }
                        nc?.present(resultVC, animated: false)
                    }
                }
                nc?.pushViewController(setTitleVC, animated: true)
            case .setNotifications:
                if let nc {
                    CreateReminderAssembly().create(from: nc)
                }
            }
        }
        
        nc.setViewControllers([scanResultVC], animated: false)
        
        from.present(nc, animated: true)
    }
}
