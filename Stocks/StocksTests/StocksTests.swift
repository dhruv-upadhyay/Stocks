//
//  StocksTests.swift
//  StocksTests
//
//  Created by Dhruv Upadhyay on 17/11/24.
//

import XCTest
@testable import Stocks

final class StocksTests: XCTestCase {
    
    var viewModel: StocksViewModel!
    var mockStocks: [StocksModel_API]!

    override func setUp() {
        super.setUp()
        viewModel = StocksViewModel()
        mockStocks = [
            StocksModel_API(name: "Bitcoin", symbol: "BTC", is_new: false, is_active: true, type: "coin"),
            StocksModel_API(name: "Ethereum", symbol: "ETH", is_new: false, is_active: true, type: "token"),
            StocksModel_API(name: "Dogecoin", symbol: "DOGE", is_new: true, is_active: false, type: "coin"),
            StocksModel_API(name: "Litecoin", symbol: "LTC", is_new: false, is_active: true, type: "coin")
        ]
        viewModel.mainStocks = mockStocks
        viewModel.displayStocks = mockStocks
    }

    override func tearDown() {
        viewModel = nil
        mockStocks = nil
        super.tearDown()
    }

    // Test: Initial configuration of filters
    func testInitialFilterOptions() {
        let options = viewModel.getFilterOptions()
        XCTAssertEqual(options.count, 2, "Filter options should have two sections.")
        XCTAssertEqual(options[0].count, 3, "First section should have three filters.")
        XCTAssertEqual(options[1].count, 3, "Second section should have three filters.")
    }

    // Test: Applying "Active Coins" filter
    func testApplyActiveCoinsFilter() {
        viewModel.applyFilter(tag: 0)
        XCTAssertEqual(viewModel.displayStocks.count, 3, "Active coins filter should display three stocks.")
        XCTAssertTrue(viewModel.displayStocks.allSatisfy { $0.is_active == true }, "All displayed stocks should be active.")
    }

    // Test: Applying "Inactive Coins" filter
    func testApplyInactiveCoinsFilter() {
        viewModel.applyFilter(tag: 1)
        XCTAssertEqual(viewModel.displayStocks.count, 1, "Inactive coins filter should display one stock.")
        XCTAssertTrue(viewModel.displayStocks.allSatisfy { $0.is_active == false }, "All displayed stocks should be inactive.")
    }

    // Test: Applying "Only Tokens" filter
    func testApplyOnlyTokensFilter() {
        viewModel.applyFilter(tag: 2)
        XCTAssertEqual(viewModel.displayStocks.count, 1, "Only tokens filter should display one stock.")
        XCTAssertTrue(viewModel.displayStocks.allSatisfy { $0.type?.lowercased() == "token" }, "All displayed stocks should be tokens.")
    }

    // Test: Applying "Only Coins" filter
    func testApplyOnlyCoinsFilter() {
        viewModel.applyFilter(tag: 3)
        XCTAssertEqual(viewModel.displayStocks.count, 3, "Only coins filter should display three stocks.")
        XCTAssertTrue(viewModel.displayStocks.allSatisfy { $0.type?.lowercased() == "coin" }, "All displayed stocks should be coins.")
    }

    // Test: Applying "New Coins" filter
    func testApplyNewCoinsFilter() {
        viewModel.applyFilter(tag: 4)
        XCTAssertEqual(viewModel.displayStocks.count, 1, "New coins filter should display one stock.")
        XCTAssertTrue(viewModel.displayStocks.allSatisfy { $0.is_new == true }, "All displayed stocks should be new.")
    }

    // Test: No filter applied (reset)
    func testNoFilterApplied() {
        viewModel.applyFilter(tag: 0) // Apply a filter
        viewModel.applyFilter(tag: 0) // Reset the filter
        XCTAssertEqual(viewModel.displayStocks.count, mockStocks.count, "Resetting the filter should display all stocks.")
    }

    // Test: Search functionality with query
    func testSearchStocks() {
        viewModel.setCache()
        viewModel.applySearch(query: "BTC")
        XCTAssertEqual(viewModel.displayStocks.count, 1, "Search with 'BTC' should display one stock.")
        XCTAssertEqual(viewModel.displayStocks.first?.symbol, "BTC", "Displayed stock should be Bitcoin.")
    }

    // Test: Search functionality with empty query
    func testSearchWithEmptyQuery() {
        viewModel.setCache()
        viewModel.applySearch(query: "")
        XCTAssertEqual(viewModel.displayStocks.count, mockStocks.count, "Empty search query should display all stocks.")
    }

    // Test: Fetch stocks method (mocked completion)
    func testFetchStocks() {
        let expectation = XCTestExpectation(description: "Fetch stocks should reload data.")
        
        NetworkManager.shared.fetchData(from: apiURL, responseType: [StocksModel_API].self) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Fetched data should not be nil.")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Fetch stocks failed with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
}
