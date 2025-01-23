//
//  AnalyseScanResultDisclaimerCell.swift
//  HairCare
//
//  Created by Андрей Чернышев on 23.01.2025.
//

import UIKit

final class AnalyseScanResultDisclaimerCell: UITableViewCell {
    lazy var label = makeLabel()
    
    var didTapDisclaimer: (() -> Void)?
    var didTapReferences: (() -> Void)?
    
    private let disclaimer: NSAttributedString
    private let references: NSAttributedString
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension AnalyseScanResultDisclaimerCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
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
            didTapDisclaimer?()
        } else if sender.didTapAttributedTextInLabel(label: label, inRange: referencesRange) {
            didTapReferences?()
        }
    }
}

// MARK: Make constraints
private extension AnalyseScanResultDisclaimerCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6.scale),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension AnalyseScanResultDisclaimerCell {
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
        contentView.addSubview(view)
        return view
    }
}
