//
//  StockCell.swift
//  Stocks
//
//  Created by Dhruv Upadhyay on 15/11/24.
//

import Foundation
import UIKit

class StockCell: UITableViewCell {
    private let stackView = UIStackView()
    private let lblTitle = UILabel()
    private let lblDesc = UILabel()
    private let imgState = UIImageView()
    private let imgNew = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setTheme()
        doLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setTheme() {
        selectionStyle = .none

        lblDesc.do {
            $0.textColor = .gray
            $0.font = .systemFont(ofSize: Sizes.size12)
        }
        
        imgNew.do {
            $0.image = UIImage(named: ImageName.icNew)
            $0.isHidden = true
        }
        
        stackView.do {
            $0.spacing = Sizes.size8
            $0.distribution = .fillEqually
            $0.axis = .vertical
        }
    }
    
    private func doLayout() {
        stackView.addAddArrangedSubviews([lblTitle, lblDesc])
        addSubviews([stackView, imgState, imgNew])
        
        stackView.addConstraints([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Sizes.size8),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Sizes.size16),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Sizes.size8)
        ])
        
        imgState.addConstraints([
            imgState.topAnchor.constraint(equalTo: self.topAnchor, constant: Sizes.size8),
            imgState.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Sizes.size8),
            imgState.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Sizes.size16),
            imgState.heightAnchor.constraint(equalToConstant: Sizes.size40),
            imgState.widthAnchor.constraint(equalToConstant: Sizes.size40),
            imgState.leftAnchor.constraint(equalTo: stackView.rightAnchor, constant: Sizes.size8)
        ])
        
        imgNew.addConstraints([
            imgNew.topAnchor.constraint(equalTo: self.topAnchor, constant: Sizes.size5),
            imgNew.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Sizes.size5),
            imgNew.heightAnchor.constraint(equalToConstant: Sizes.size25)
        ])
    }
    
    func setData(data: StocksModel_API) {
        if let value = data.name {
            lblTitle.text = value
        }
        
        if let value = data.symbol {
            lblDesc.text = value
        }
        
        if let value = data.is_new {
            imgNew.isHidden = !value
        }
        
        if let value = data.is_active, value == true {
            if let type = data.type {
                var strImage = ""
                switch type {
                case "coin":
                    strImage = ImageName.icActiveCoin
                case "token":
                    strImage = ImageName.isActiveToken
                default:
                    strImage = ""
                }
                
                if !strImage.isEmpty {
                    imgState.image = UIImage(named: strImage)
                }
            }
        } else {
            imgState.image = UIImage(named: ImageName.isInactive)
        }
    }
}
