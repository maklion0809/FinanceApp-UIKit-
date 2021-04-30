//
//  Transaction.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 12.12.2020.
//

import Foundation
import UIKit

enum ExpInc {
    case expense
    case income
}

struct Transaction {
    var sum: String
    var expInc: ExpInc
    var date: String
    var note: String
    var category: Category
    var currency: String
}
