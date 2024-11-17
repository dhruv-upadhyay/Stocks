//
//  StocksViewModel.swift
//  Stocks
//
//  Created by Dhruv Upadhyay on 15/11/24.
//

import Foundation

class StocksViewModel {
    
    var displayStocks = [StocksModel_API]()
    var mainStocks = [StocksModel_API]()
    private var displayCahceStocks = [StocksModel_API]()
    
    private var filterOptions = [[FilterOption]]()
    private var isSearch: Bool = false
    
    init() {
        configData()
    }
    
    private func configData() {
        filterOptions = [[FilterOption(title: "Active Coins", isSelected: false, tag: 0), FilterOption(title: "Inactive Coins", isSelected: false, tag: 1), FilterOption(title: "Only Tokens", isSelected: false, tag: 2)], [FilterOption(title: "Only Coins", isSelected: false, tag: 3), FilterOption(title: "New Coins", isSelected: false, tag: 4), FilterOption(title: "", isSelected: false, tag: 5)]]
    }
    
    func fetchStocks(completion: @escaping() -> Void) {
        NetworkManager.shared.fetchData(from: apiURL, responseType: [StocksModel_API].self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let data):
                strongSelf.mainStocks = data
                strongSelf.displayStocks = data
                completion()
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
    
    func getStock(index: Int) -> StocksModel_API {
        return displayStocks[index]
    }
    
    func getRows() -> Int {
        return displayStocks.count
    }
    
    func getFilterOptions() -> [[FilterOption]] {
        return filterOptions
    }
    
    func applyFilter(tag: Int) {
        filterOptions = filterOptions.map { section in
            section.map { option in
                var updatedOption = option
                if option.tag == tag {
                    updatedOption.isSelected = !updatedOption.isSelected
                }
                return updatedOption
            }
        }
        
        displayStocks = []
        
        for section in filterOptions {
            for option in section where option.isSelected {
                switch option.tag {
                case 0:
                    displayStocks.append(contentsOf: mainStocks.filter { $0.is_active == true })
                case 1:
                    displayStocks.append(contentsOf: mainStocks.filter { $0.is_active == false })
                case 2:
                    displayStocks.append(contentsOf: mainStocks.filter { $0.type?.lowercased() == "token" })
                case 3:
                    displayStocks.append(contentsOf: mainStocks.filter { $0.type?.lowercased() == "coin" })
                case 4:
                    displayStocks.append(contentsOf: mainStocks.filter { $0.is_new == true })
                default:
                    displayStocks = mainStocks
                }
            }
        }
        
        let isFilterApplied = filterOptions.flatMap { $0 }.contains { $0.isSelected }
        
        if !isFilterApplied {
            displayStocks = mainStocks
        }
        
        setCache()
    }
    
    func setCache() {
         displayCahceStocks = displayStocks
    }
    
    func applySearch(query: String) {
        if query.isEmpty {
            displayStocks = displayCahceStocks
        } else {
            displayStocks = displayCahceStocks.filter { stock in
                stock.name?.lowercased().contains(query.lowercased()) == true ||
                stock.symbol?.lowercased().contains(query.lowercased()) == true
            }
        }
    }
}
