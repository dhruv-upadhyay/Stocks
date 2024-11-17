//
//  NavigationView.swift
//  Stocks
//
//  Created by Dhruv Upadhyay on 17/11/24.
//

import UIKit

protocol NavigationViewDelegate: NSObject {
    func onClickOption(tag: Int)
    func textDidChange(searchText: String)
}

class NavigationView: UIView {
    private let lblTitle = UILabel()
    private let searchBar = UISearchBar()
    private let stackView = UIStackView()
    private let filterView = StockFilterView()
    
    weak var delegate: NavigationViewDelegate?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTheme()
        doLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTheme() {
        backgroundColor = .white
        filterView.do {
            $0.delegate = self
        }
        
        lblTitle.do {
            $0.text = Titles.stocks
            $0.textAlignment = .center
            $0.font = .boldSystemFont(ofSize: Sizes.size24)
        }
        
        stackView.do {
            $0.spacing = 10
            $0.distribution = .fill
            $0.axis = .vertical
        }
        
        searchBar.do {
            $0.delegate = self
            $0.placeholder = Placeholders.searchStocks
        }
    }
    
    private func doLayout() {
        
        stackView.addAddArrangedSubviews([lblTitle, searchBar, filterView])
        addSubview(stackView)
        
        stackView.addConstraints([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Sizes.size8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.size8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Sizes.size8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.size8)
        ])
    }
    
    func setFilterData(data: [[FilterOption]]) {
        filterView.setData(options: data)
    }
}

extension NavigationView: StockFilterViewDelegate {
    func onClickOption(tag: Int) {
        delegate?.onClickOption(tag: tag)
    }
}

extension NavigationView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.textDidChange(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
