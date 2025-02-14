//
//  PreScanObnStartView.swift
//  HairCare
//
//  Created by Андрей Чернышев on 24.01.2025.
//

import UIKit

final class PreScanObnStartView: UIView {
    lazy var container = makeContainer()
    lazy var imageView = makeImageView()
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var button = makeButton()
    
    private let start: () -> Void
    
    init(start: @escaping () -> Void) {
        self.start = start
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension PreScanObnStartView {
    func initialize() {
        backgroundColor = Appearance.mono100
        clipsToBounds = true
    }
    
    @objc
    func didTap() {
        start()
    }
}

// MARK: Make constraints
private extension PreScanObnStartView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.scale),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.scale),
            container.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 140.scale),
            imageView.heightAnchor.constraint(equalToConstant: 140.scale),
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: container.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24.scale),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24.scale),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 164.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.scale),
            subTitleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            button.heightAnchor.constraint(equalToConstant: 54.scale),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -14.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension PreScanObnStartView {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "PreScanOnb.Start.Image")
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono200)
            .font(Fonts.Roboto.bold(size: 22.scale))
            .lineHeight(30.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "PreScanOnb.Start.Title".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeSubTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono200.withAlphaComponent(0.5))
            .font(Fonts.Roboto.regular(size: 14.scale))
            .lineHeight(20.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "PreScanOnb.Start.SubTitle".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.mono100)
            .font(Fonts.Roboto.bold(size: 16.scale))
        
        let view = UIButton()
        view.setAttributedTitle("PreScanOnb.Start.Button".localized.attributed(with: attrs), for: .normal)
        view.backgroundColor = Appearance.mono200
        view.layer.cornerRadius = 16.scale
        view.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
