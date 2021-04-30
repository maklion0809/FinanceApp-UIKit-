//
//  File.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 12.12.2020.
//

import Foundation

struct Purse {
    var name: String
    var sum: String
    var period: String
    var currency: [String]
    var transactions: [Transaction]
    var budgets: [Budget]
    var depts: [Dept]
}
