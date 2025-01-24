//
//  PreScanOnbView.swift
//  HairCare
//
//  Created by Андрей Чернышев on 24.01.2025.
//

import UIKit

final class PreScanOnbView: UIView {
    enum Slide: Int {
        case start
        case touch
        case splitEnds
        case afterWashing
        case looseDaily
    }
    
    lazy var container = makeContainer()
    lazy var titleLabel = makeTitleLabel()
    lazy var stepsView = makeStepsView()
    lazy var closeButton = makeCloseButton()
    
    private lazy var slidesViews: [Slide: UIView] = [
        .start: PreScanObnStartView(start: { [weak self] in
            self?.scroll(from: .start, to: .touch)
        }),
        .touch: PreScanOnbListView(question: .touch, complete: { [weak self] in
            self?.scroll(from: .touch, to: .splitEnds)
        }),
        .splitEnds: PreScanOnbListView(question: .splitEnds, complete: { [weak self] in
            self?.scroll(from: .splitEnds, to: .afterWashing)
        }),
        .afterWashing: PreScanOnbListView(question: .afterWashing, complete: { [weak self] in
            self?.scroll(from: .afterWashing, to: .looseDaily)
        }),
        .looseDaily: PreScanOnbListView(question: .looseDaily, complete: { [weak self] in
            self?.finish()
        })
    ]
    
    private let finish: () -> Void
    
    init(finish: @escaping () -> Void) {
        self.finish = finish
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        slidesViews.map { $1 }.enumerated().forEach { [weak self] index, slideView in
            guard let self else { return }
            
            slideView.frame.size = bounds.size
        }
    }
}

// MARK: Private
private extension PreScanOnbView {
    func initialize() {
        backgroundColor = Appearance.mono100
        
        if let view = slidesViews[.start] {
            view.frame.origin = CGPoint.zero
            container.addSubview(view)
        }
        
        stepsView.update(at: .start)
    }
    
    func scroll(from: Slide, to: Slide) {
        guard let currentView = slidesViews[from], let scrollToView = slidesViews[to] else { return }
        
        scrollToView.frame.origin = CGPoint(x: bounds.size.width, y: 0)
        
        container.addSubview(scrollToView)
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self else { return }
            
            currentView.frame.origin = CGPoint(x: -bounds.size.width, y: 0)
            scrollToView.frame.origin = CGPoint(x: 0, y: 0)
        }, completion: { [weak self] result in
            guard let self = self else { return }
            
            currentView.removeFromSuperview()
            
            stepsView.update(at: to)
        })
    }
}

// MARK: Make constraints
private extension PreScanOnbView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 6.scale),
            titleLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stepsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.scale),
            stepsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.scale),
            stepsView.heightAnchor.constraint(equalToConstant: 6.scale),
            stepsView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 72.scale)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 24.scale),
            closeButton.heightAnchor.constraint(equalToConstant: 24.scale),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension PreScanOnbView {
    func makeContainer() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.mono200)
            .font(Fonts.Roboto.bold(size: 22.scale))
            .lineHeight(30.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "PreScanOnb.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeStepsView() -> PreScanOnbStepsView {
        let view = PreScanOnbStepsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCloseButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "PreScanOnb.Close"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
