//
//  OReferencesView.swift
//  HairCare
//
//  Created by Андрей Чернышев on 14.02.2025.
//

import UIKit

final class OReferencesView: OnboardingSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var textLabel = makeTextLabel()
    lazy var imageView = makeImageView()
    lazy var continueButton = makeContinueButton()
    
    init() {
        super.init(slide: .references)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OReferencesView {
    func initialize() {
        backgroundColor = Appearance.mono100
    }
    
    @objc
    func tapped(sender: UITapGestureRecognizer) {
        guard
            let label = sender.view as? UILabel,
            let text = label.text as NSString?
        else { return }
        
        let nlmRange = text.range(of: GlobalDefinitions.References.nlm.absoluteString)
        let cdcRange = text.range(of: GlobalDefinitions.References.cdc.absoluteString)
        
        if sender.didTapAttributedTextInLabel(label: label, inRange: nlmRange) {
            UIApplication.shared.open(GlobalDefinitions.References.nlm, options: [:], completionHandler: nil)
        } else if sender.didTapAttributedTextInLabel(label: label, inRange: cdcRange) {
            UIApplication.shared.open(GlobalDefinitions.References.cdc, options: [:], completionHandler: nil)
        }
    }
}

// MARK: Make constraints
private extension OReferencesView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: ScreenSize.isIphoneXFamily ? 88.scale : 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13.scale)
        ])
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 246.scale : 180.scale),
            imageView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 246.scale : 180.scale),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 32.scale)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            continueButton.heightAnchor.constraint(equalToConstant: 54.scale),
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -14.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OReferencesView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono200)
            .font(Fonts.Roboto.bold(size: 36.scale))
            .lineHeight(43.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Onboarding.References.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTextLabel() -> UILabel {
        let bAttrs = TextAttributes()
            .textColor(Appearance.mono200)
            .font(Fonts.Roboto.bold(size: 16.scale))
            .lineHeight(19.scale)
            .textAlignment(.left)
        let rAttrs = TextAttributes()
            .textColor(Appearance.mono200)
            .font(Fonts.Roboto.regular(size: 16.scale))
            .lineHeight(19.scale)
            .textAlignment(.left)
        let lAttrs = TextAttributes()
            .textColor(Appearance.main200)
            .font(Fonts.Roboto.regular(size: 16.scale))
            .underlineColor(Appearance.main200)
            .underlineStyle(.single)
        
        let result = NSMutableAttributedString()
        result.append("Onboarding.References.Text1".localized.attributed(with: bAttrs))
        result.append("Onboarding.References.Text2".localized.attributed(with: rAttrs))
        
        let nlm = GlobalDefinitions.References.nlm.absoluteString
        let cdc = GlobalDefinitions.References.cdc.absoluteString
        let links = String(format: "%@\n%@", nlm, cdc)
        result.append(links.attributed(with: lAttrs))
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        
        let view = UILabel()
        view.attributedText = result
        view.numberOfLines = 0
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(gesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Onboarding.References")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeContinueButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.mono100)
            .font(Fonts.Roboto.bold(size: 16.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Continue".localized.attributed(with: attrs), for: .normal)
        view.layer.cornerRadius = 16.scale
        view.backgroundColor = Appearance.mono200
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        addSubview(view)
        return view
    }
}
