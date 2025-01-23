//
//  ReferencesView.swift
//  HairCare
//
//  Created by Андрей Чернышев on 23.01.2025.
//

import UIKit

final class ReferencesView: UIView {
    lazy var backButton = makeBackButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var scrollView = makeScrollView()
    lazy var block1Label = makeBlock1Label()
    lazy var block2Label = makeBlock2Label()
    lazy var block3Label = makeBlock3Label()
    lazy var link1Button = makeLinkButton(link: "https://www.nlm.nih.gov")
    lazy var link2Button = makeLinkButton(link: "https://www.cdc.gov/health-topics.html")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension ReferencesView {
    func initialize() {
        backgroundColor = Appearance.mono100
    }
}

// MARK: Make constraints
private extension ReferencesView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 24.scale),
            backButton.heightAnchor.constraint(equalToConstant: 24.scale),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 6.scale),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 2.scale),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            block1Label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            block1Label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            block1Label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            block1Label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            block1Label.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 32.scale)
        ])
        
        NSLayoutConstraint.activate([
            block2Label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            block2Label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            block2Label.topAnchor.constraint(equalTo: block1Label.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            block3Label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            block3Label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            block3Label.topAnchor.constraint(equalTo: block2Label.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            link1Button.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            link1Button.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            link1Button.topAnchor.constraint(equalTo: block3Label.bottomAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            link2Button.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            link2Button.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            link2Button.topAnchor.constraint(equalTo: link1Button.bottomAnchor, constant: 2.scale),
            link1Button.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension ReferencesView {
    func makeBackButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "Back.Black"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }

    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono200)
            .font(Fonts.Roboto.bold(size: 22.scale))
            .lineHeight(30.scale)
            .textAlignment(.left)
        
        let view = UILabel()
        view.attributedText = "References.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.backgroundColor = UIColor.clear
        view.contentInset = UIEdgeInsets(b: 16.scale)
        view.setContentOffset(CGPoint.zero, animated: false)
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeBlock1Label() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono200)
            .font(Fonts.Roboto.bold(size: 16.scale))
            .lineHeight(19.2.scale)
            .textAlignment(.left)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "References.Text1".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
        return view
    }
    
    func makeBlock2Label() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono200)
            .font(Fonts.Roboto.regular(size: 16.scale))
            .lineHeight(19.2.scale)
            .textAlignment(.left)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "References.Text2".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
        return view
    }
    
    func makeBlock3Label() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono200)
            .font(Fonts.Roboto.regular(size: 16.scale))
            .lineHeight(19.2.scale)
            .textAlignment(.left)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "References.Text3".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
        return view
    }
    
    func makeLinkButton(link: String) -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.main200)
            .font(Fonts.Roboto.regular(size: 16.scale))
        
        let view = UIButton()
        view.contentHorizontalAlignment = .left
        view.backgroundColor = UIColor.clear
        view.setAttributedTitle(link.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
        return view
    }
}
