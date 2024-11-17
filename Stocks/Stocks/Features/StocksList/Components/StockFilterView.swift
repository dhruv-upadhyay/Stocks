//
//  StockFilterView.swift
//  Stocks
//
//  Created by Dhruv Upadhyay on 15/11/24.
//

import UIKit

protocol StockFilterViewDelegate: NSObject {
    func onClickOption(tag: Int)
}

class StockFilterView: UIView {
    private let stackView = UIStackView()
    weak var delegate: StockFilterViewDelegate?
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setTheme()
        doLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setTheme() {
        backgroundColor = .lightGray.withAlphaComponent(Sizes.size_p5)
        
        stackView.do {
            $0.spacing = 5
            $0.distribution = .fillEqually
            $0.axis = .vertical
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func doLayout() {
        addSubview(stackView)
        stackView.addConstraints([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Sizes.size8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.size8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Sizes.size8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.size8)
        ])
    }
    
    func setData(options: [[FilterOption]]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for option in options {
            let subStackView = UIStackView()
            subStackView.do {
                $0.spacing = Sizes.size5
                $0.distribution = .fillEqually
                $0.axis = .horizontal
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
            
            for subOption in option {
                let subView = UIView()
                let clickGesture = UITapGestureRecognizer(target: self, action: #selector(onClickOption))
                subView.do {
                    $0.layer.borderWidth = !subOption.title.isEmpty ? Sizes.size1 : Sizes.zero
                    $0.layer.borderColor = !subOption.title.isEmpty ? UIColor.black.cgColor: UIColor.clear.cgColor
                    $0.layer.cornerRadius = !subOption.title.isEmpty ? Sizes.size5 : Sizes.zero
                    $0.tag = subOption.tag
                    $0.backgroundColor = !subOption.title.isEmpty ? subOption.isSelected ? .black : .white : .clear
                    $0.isUserInteractionEnabled = !subOption.title.isEmpty
                    $0.addGestureRecognizer(clickGesture)
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
                
                let label = UILabel()
                label.do {
                    let tickMark = subOption.isSelected ? "✔︎" : ""
                    $0.text = "\(tickMark) \(subOption.title)"
                    $0.textAlignment = .center
                    $0.font = .systemFont(ofSize: Sizes.size14)
                    $0.textColor = subOption.isSelected ? .white : .black
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
                
                subView.addSubview(label)
                
                NSLayoutConstraint.activate([
                    label.topAnchor.constraint(equalTo: subView.topAnchor, constant: Sizes.size8),
                    label.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: Sizes.size4),
                    label.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -Sizes.size8),
                    label.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -Sizes.size4)
                ])
                
                subView.layoutIfNeeded()
                subView.layer.cornerRadius = subView.frame.height / Sizes.size2
                
                subStackView.addArrangedSubview(subView)
            }
            stackView.addArrangedSubview(subStackView)
        }
    }
    
    @objc func onClickOption(_ sender: UITapGestureRecognizer) {
        if let value = sender.view?.tag {
            delegate?.onClickOption(tag: value)
        }
    }
}

