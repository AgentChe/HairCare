//
//  PreScanOnbListView.swift
//  HairCare
//
//  Created by Андрей Чернышев on 24.01.2025.
//

import UIKit

final class PreScanOnbListView: UIView {
    enum Question {
        case touch
        case splitEnds
        case afterWashing
        case looseDaily
    }
    
    lazy var titleLabel = makeTitleLabel()
    lazy var stackView = makeStackView()
    lazy var button = makeButton()
    
    private let question: Question
    private let complete: () -> Void
    
    private lazy var disableButtonAttrs = TextAttributes()
        .textColor(Appearance.mono200.withAlphaComponent(0.5))
        .font(Fonts.Roboto.bold(size: 16.scale))
    private lazy var enableButtonAttrs = TextAttributes()
        .textColor(Appearance.mono100)
        .font(Fonts.Roboto.bold(size: 16.scale))
    
    init(question: Question, complete: @escaping () -> Void) {
        self.question = question
        self.complete = complete
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
        updateEnable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension PreScanOnbListView {
    func initialize() {
        backgroundColor = Appearance.mono100
        clipsToBounds = true
        
        let answers = question.answers
        answers.forEach { answer in
            let view = PreScanOnbListCellView(text: answer)
            view.translatesAutoresizingMaskIntoConstraints = false 
            stackView.addArrangedSubview(view)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCell(gesture:)))
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc
    func didTapCell(gesture: UITapGestureRecognizer) {
        guard let cell = gesture.view as? PreScanOnbListCellView else { return }
        
        let cells = stackView.arrangedSubviews.compactMap { $0 as? PreScanOnbListCellView }
        
        cells.forEach { $0.marked = false }
        cell.marked = true
        
        updateEnable()
    }
    
    func updateEnable() {
        let cells = stackView.arrangedSubviews.compactMap { $0 as? PreScanOnbListCellView }
        let marked = cells.contains(where: { $0.marked })
        
        button.isEnabled = marked
        button.backgroundColor = marked ? Appearance.mono200 : Appearance.main100
        
        let attrs = marked ? enableButtonAttrs : disableButtonAttrs
        button.setAttributedTitle("Next".localized.attributed(with: attrs), for: .normal)
    }
    
    @objc
    func didTapButton() {
        complete()
    }
}

// MARK: Make constraints
private extension PreScanOnbListView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 118.scale)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.scale)
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
private extension PreScanOnbListView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono200)
            .font(Fonts.Roboto.bold(size: 18.scale))
            .lineHeight(21.scale)
            .textAlignment(.left)
        
        let view = UILabel()
        view.attributedText = question.title.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeStackView() -> UIStackView {
        let view = UIStackView()
        view.backgroundColor = UIColor.clear
        view.axis = .vertical
        view.spacing = 18.scale
        view.distribution = .fill
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let view = UIButton()
        view.layer.cornerRadius = 16.scale
        view.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

// MARK: Additional
private extension PreScanOnbListView.Question {
    var title: String {
        switch self {
        case .touch:
            return "PreScanOnb.List.Title.Touch".localized
        case .splitEnds:
            return "PreScanOnb.List.Title.SplitEnds".localized
        case .afterWashing:
            return "PreScanOnb.List.Title.AfterWashing".localized
        case .looseDaily:
            return "PreScanOnb.List.Title.LooseDaily".localized
        }
    }
    
    var answers: [String] {
        switch self {
        case .touch:
            return [
                "PreScanOnb.List.Touch.Cell1".localized,
                "PreScanOnb.List.Touch.Cell2".localized,
                "PreScanOnb.List.Touch.Cell3".localized,
                "PreScanOnb.List.Touch.Cell4".localized
            ]
        case .splitEnds:
            return [
                "PreScanOnb.List.SplitEnds.Cell1".localized,
                "PreScanOnb.List.SplitEnds.Cell2".localized,
                "PreScanOnb.List.SplitEnds.Cell3".localized,
                "PreScanOnb.List.SplitEnds.Cell4".localized
            ]
        case .afterWashing:
            return [
                "PreScanOnb.List.AfterWashing.Cell1".localized,
                "PreScanOnb.List.AfterWashing.Cell2".localized,
                "PreScanOnb.List.AfterWashing.Cell3".localized,
                "PreScanOnb.List.AfterWashing.Cell4".localized
            ]
        case .looseDaily:
            return [
                "PreScanOnb.List.LooseDaily.Cell1".localized,
                "PreScanOnb.List.LooseDaily.Cell2".localized,
                "PreScanOnb.List.LooseDaily.Cell3".localized,
                "PreScanOnb.List.LooseDaily.Cell4".localized
            ]
        }
    }
}
