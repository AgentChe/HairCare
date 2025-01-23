//
//  CatalogDisclaimerView.swift
//  HairCare
//
//  Created by Андрей Чернышев on 23.01.2025.
//

import UIKit
import RxSwift
import RxCocoa

final class CatalogDisclaimerView: UIView {
    lazy var separator = makeSeparator()
    lazy var label = makeLabel()
    
    private lazy var didTapDisclaimerTrigger = PublishRelay<Void>()
    private lazy var didTapReferencesTrigger = PublishRelay<Void>()
    
    private let disclaimer: NSAttributedString
    private let references: NSAttributedString
    
    private let withSeparator: Bool
    
    init(withSeparator: Bool = true) {
        self.withSeparator = withSeparator
        
        let attrs = TextAttributes()
            .textColor(Appearance.mono200.withAlphaComponent(0.5))
            .font(Fonts.Roboto.regular(size: 14.scale))
            .lineHeight(20.scale)
            .textAlignment(.center)
        let boldAttrs = TextAttributes()
            .textColor(Appearance.mono200.withAlphaComponent(0.5))
            .font(Fonts.Roboto.bold(size: 14.scale))
            .lineHeight(20.scale)
            .textAlignment(.center)
        let linkAttrs = TextAttributes()
            .textColor(Appearance.mono200.withAlphaComponent(0.5))
            .font(Fonts.Roboto.regular(size: 14.scale))
            .lineHeight(20.scale)
            .textAlignment(.center)
            .underlineStyle(.single)
            .underlineColor(Appearance.mono200.withAlphaComponent(0.5))
        
        disclaimer = {
            let result = NSMutableAttributedString()
            result.append("AnalyseScanResult.Disclaimer.1".localized.attributed(with: attrs))
            result.append("AnalyseScanResult.Disclaimer.2".localized.attributed(with: boldAttrs))
            result.append("AnalyseScanResult.Disclaimer.3".localized.attributed(with: attrs))
            result.append("AnalyseScanResult.Disclaimer.4".localized.attributed(with: linkAttrs))
            return result
        }()
        
        references = {
            let result = NSMutableAttributedString()
            result.append("AnalyseScanResult.Disclaimer.5".localized.attributed(with: attrs))
            result.append("AnalyseScanResult.Disclaimer.4".localized.attributed(with: linkAttrs))
            return result
        }()
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension CatalogDisclaimerView {
    var didTapDisclaimer: Signal<Void> {
        didTapDisclaimerTrigger.asSignal()
    }
    
    var didTapReferences: Signal<Void> {
        didTapReferencesTrigger.asSignal()
    }
}

// MARK: Private
private extension CatalogDisclaimerView {
    func initialize() {
        backgroundColor = Appearance.mono100
    }
    
    @objc
    func tapped(sender: UITapGestureRecognizer) {
        guard
            let label = sender.view as? UILabel,
            let text = label.text as NSString?
        else { return }
        
        let disclaimerRange = text.range(of: disclaimer.string)
        let referencesRange = text.range(of: references.string)
        
        if sender.didTapAttributedTextInLabel(label: label, inRange: disclaimerRange) {
            didTapDisclaimerTrigger.accept(Void())
        } else if sender.didTapAttributedTextInLabel(label: label, inRange: referencesRange) {
            didTapReferencesTrigger.accept(Void())
        }
    }
}

// MARK: Make constraints
private extension CatalogDisclaimerView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.scale),
            separator.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            label.topAnchor.constraint(equalTo: topAnchor, constant: withSeparator ? 5.scale : 0),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension CatalogDisclaimerView {
    func makeSeparator() -> UIView {
        let view = UIView()
        view.isHidden = !withSeparator
        view.backgroundColor = Appearance.main700
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let result = NSMutableAttributedString()
        result.append(disclaimer)
        result.append(references)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        
        let view = UILabel()
        view.attributedText = result
        view.numberOfLines = 0
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
