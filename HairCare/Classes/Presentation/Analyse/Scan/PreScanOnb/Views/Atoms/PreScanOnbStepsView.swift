//
//  PreScanOnbStepsView.swift
//  HairCare
//
//  Created by Андрей Чернышев on 24.01.2025.
//

import UIKit

final class PreScanOnbStepsView: UIView {
    lazy var touchDivisionView = makeDivisionView()
    lazy var splitEndsDivisionView = makeDivisionView()
    lazy var afterWashingDivisionView = makeDivisionView()
    lazy var looseDailyDivisionView = makeDivisionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension PreScanOnbStepsView {
    func update(at slide: PreScanOnbView.Slide) {
        let highlight = Appearance.mono200
        let notHighlight = Appearance.main100
        
        touchDivisionView.backgroundColor = slide.equalOrGreater(than: .touch) ? highlight : notHighlight
        splitEndsDivisionView.backgroundColor = slide.equalOrGreater(than: .splitEnds) ? highlight : notHighlight
        afterWashingDivisionView.backgroundColor = slide.equalOrGreater(than: .afterWashing) ? highlight : notHighlight
        looseDailyDivisionView.backgroundColor = slide.equalOrGreater(than: .looseDaily) ? highlight : notHighlight
        
        isHidden = {
            switch slide {
            case .start:
                return true
            case .touch, .splitEnds, .afterWashing, .looseDaily:
                return false
            }
        }()
    }
}

// MARK: Private
private extension PreScanOnbStepsView {
    func initialize() {
        backgroundColor = UIColor.clear
    }
}

// MARK: Make constraints
private extension PreScanOnbStepsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            touchDivisionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            touchDivisionView.topAnchor.constraint(equalTo: topAnchor),
            touchDivisionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            touchDivisionView.widthAnchor.constraint(equalTo: splitEndsDivisionView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            splitEndsDivisionView.leadingAnchor.constraint(equalTo: touchDivisionView.trailingAnchor, constant: 6.scale),
            splitEndsDivisionView.topAnchor.constraint(equalTo: topAnchor),
            splitEndsDivisionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            splitEndsDivisionView.widthAnchor.constraint(equalTo: afterWashingDivisionView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            afterWashingDivisionView.leadingAnchor.constraint(equalTo: splitEndsDivisionView.trailingAnchor, constant: 6.scale),
            afterWashingDivisionView.topAnchor.constraint(equalTo: topAnchor),
            afterWashingDivisionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            afterWashingDivisionView.widthAnchor.constraint(equalTo: looseDailyDivisionView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            looseDailyDivisionView.leadingAnchor.constraint(equalTo: afterWashingDivisionView.trailingAnchor, constant: 6.scale),
            looseDailyDivisionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            looseDailyDivisionView.topAnchor.constraint(equalTo: topAnchor),
            looseDailyDivisionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PreScanOnbStepsView {
    func makeDivisionView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 2.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}

// MARK: Additional
private extension PreScanOnbView.Slide {
    func equalOrGreater(than slide: PreScanOnbView.Slide) -> Bool {
        rawValue >= slide.rawValue
    }
}
