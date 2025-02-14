//
//  HomeExploreItemButton.swift
//  ScinCare
//
//  Created by Андрей Чернышев on 22.10.2024.
//

import UIKit

final class HomeExploreItemButton: UIButton {
    enum Item {
        case recipes
        case insights
        case procedures
        case disease
        case glossary
        case disclaimer
        case references
    }
    
    lazy var iconView = makeIconView()
    lazy var headerLabel = makeHeaderLabel()
    lazy var textLabel = makeTextLabel()
    
    let item: Item
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        makeConstrainst()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension HomeExploreItemButton {
    func initialize() {
        backgroundColor = {
            switch item {
            case .recipes:
                return UIColor(integralRed: 240, green: 219, blue: 255)
            case .insights:
                return UIColor(integralRed: 201, green: 241, blue: 255)
            case .procedures, .disease, .glossary, .disclaimer, .references:
                return Appearance.main700
            }
        }()
        layer.cornerRadius = 16.scale
    }
}

// MARK: Make constraints
private extension HomeExploreItemButton {
    func makeConstrainst() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 48.scale),
            iconView.heightAnchor.constraint(equalToConstant: 48.scale),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            headerLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10.scale)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            textLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 4.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension HomeExploreItemButton {
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: item.iconName)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeHeaderLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono200)
            .font(Fonts.Roboto.medium(size: 18.scale))
            .lineHeight(21.scale)
            .textAlignment(.left)
        
        let view = UILabel()
        view.attributedText = item.title.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTextLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = item.text
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

// MARK: Additional
private extension HomeExploreItemButton.Item {
    var iconName: String {
        switch self {
        case .recipes:
            return "Home.Explore.Recipes"
        case .insights:
            return "Home.Explore.Insights"
        case .procedures:
            return "Home.Explore.Procedures"
        case .disease:
            return "Home.Explore.Disease"
        case .glossary:
            return "Home.Explore.Glossary"
        case .disclaimer:
            return "Home.Explore.Disclaimer"
        case .references:
            return "Home.Explore.References"
        }
    }
    
    var title: String {
        switch self {
        case .recipes:
            return "Home.Explore.Recipes.Title".localized
        case .insights:
            return "Home.Explore.Insights.Title".localized
        case .procedures:
            return "Home.Explore.Procedures.Title".localized
        case .disease:
            return "Home.Explore.Disease.Title".localized
        case .glossary:
            return "Home.Explore.Glossary.Title".localized
        case .disclaimer:
            return "Home.Explore.Disclaimer.Title".localized
        case .references:
            return "Home.Explore.References.Title".localized
        }
    }
    
    var text: NSAttributedString {
        let attrs = TextAttributes()
            .textColor(Appearance.mono200.withAlphaComponent(0.5))
            .font(Fonts.Roboto.regular(size: 14.scale))
            .lineHeight(20.scale)
            .textAlignment(.left)
        
        switch self {
        case .recipes:
            return "Home.Explore.Recipes.Text".localized.attributed(with: attrs)
        case .insights:
            return "Home.Explore.Insights.Text".localized.attributed(with: attrs)
        case .procedures:
            return "Home.Explore.Procedures.Text".localized.attributed(with: attrs)
        case .disease:
            return "Home.Explore.Disease.Text".localized.attributed(with: attrs)
        case .glossary:
            return "Home.Explore.Glossary.Text".localized.attributed(with: attrs)
        case .disclaimer:
            let boldAttrs = TextAttributes()
                .textColor(Appearance.mono200.withAlphaComponent(0.5))
                .font(Fonts.Roboto.bold(size: 14.scale))
                .lineHeight(20.scale)
                .textAlignment(.left)
            
            let result = NSMutableAttributedString()
            result.append("Home.Explore.Disclaimer.Text.1".localized.attributed(with: attrs))
            result.append("Home.Explore.Disclaimer.Text.2".localized.attributed(with: boldAttrs))
            result.append("Home.Explore.Disclaimer.Text.3".localized.attributed(with: attrs))
            return result
        case .references:
            return "Home.Explore.References.Text".localized.attributed(with: attrs)
        }
    }
}
