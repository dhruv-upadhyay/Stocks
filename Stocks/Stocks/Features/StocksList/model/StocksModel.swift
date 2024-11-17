//
//  StocksModel.swift
//  Stocks
//
//  Created by Dhruv Upadhyay on 15/11/24.
//

import Foundation

struct StocksModel_API : Codable {
    let name : String?
    let symbol : String?
    let is_new : Bool?
    let is_active : Bool?
    let type : String?
}

struct FilterOption {
    let title: String
    var isSelected: Bool
    let tag: Int
}
