//
//  PreScanOnbListCellView.swift
//  HairCare
//
//  Created by Андрей Чернышев on 24.01.2025.
//

import UIKit

final class PreScanOnbListCellView: UIView {
    lazy var marked: Bool = false {
        didSet {
            update()
        }
    }
    
    lazy var label = makeLabel()
    lazy var iconView = makeIconView()
    
    private let text: String
    
    init(text: String) {
        self.text = text
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension PreScanOnbListCellView {
    func initialize() {
        backgroundColor = UIColor.clear
    }
    
    func update() {
        iconView.image = UIImage(named: marked ? "PreScanOnb.Mark.S" : "PreScanOnb.Mark.D")
    }
}

// MARK: Make constraints
private extension PreScanOnbListCellView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32.scale),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 2.5.scale),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2.5.scale)
        ])
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 24.scale),
            iconView.heightAnchor.constraint(equalToConstant: 24.scale),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PreScanOnbListCellView {
    func makeLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono200)
            .font(Fonts.Roboto.regular(size: 16.scale))
            .lineHeight(19.scale)
            .textAlignment(.left)
        
        let view = UILabel()
        view.attributedText = text.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
