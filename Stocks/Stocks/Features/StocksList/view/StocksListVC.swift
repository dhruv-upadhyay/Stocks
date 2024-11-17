//
//  StocksListVC.swift
//  Stocks
//
//  Created by Dhruv Upadhyay on 15/11/24.
//

import UIKit

class StocksListVC: UIViewController {
    private let tableView = UITableView()
    private let navView = NavigationView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    let viewModel = StocksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        doLayout()
    }
    
    private func setTheme() {
        view.backgroundColor = .white
        
        navView.do {
            $0.setFilterData(data: viewModel.getFilterOptions())
            $0.delegate = self
        }
        
        tableView.do {
            $0.dataSource = self
            $0.register(StockCell.self, forCellReuseIdentifier: CellName.stockCell)
            $0.separatorStyle = .none
            $0.backgroundColor = .white
        }
        
        self.showActivityIndicator()
        viewModel.fetchStocks {
            DispatchQueue.main.async {
                self.hideActivityIndicator()
                self.tableView.reloadData()
            }
        }
        
        activityIndicator.do {
            $0.hidesWhenStopped = true
            $0.color = .gray
        }
    }
    
    private func doLayout() {
        view.addSubviews([navView, tableView, activityIndicator])

        navView.addConstraints([
            navView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.addConstraints([
            tableView.topAnchor.constraint(equalTo: navView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        activityIndicator.addConstraints([
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
}

extension StocksListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellName.stockCell, for: indexPath) as? StockCell {
            cell.setData(data: viewModel.getStock(index: indexPath.row))
            return cell
        }
        return UITableViewCell()
    }
}
extension StocksListVC: NavigationViewDelegate {
    func onClickOption(tag: Int) {
        viewModel.applyFilter(tag: tag)
        navView.setFilterData(data: viewModel.getFilterOptions())
        tableView.reloadData()
    }
    
    func textDidChange(searchText: String) {
        viewModel.applySearch(query: searchText)
        tableView.reloadData()
    }
}
