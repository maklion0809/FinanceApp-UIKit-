//
//  Dept.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 17.12.2020.
//

import Foundation

enum WhoAndWhom {
    case who
    case whom
}

struct Dept{
    var sum: String
    var name: String
    var dateEnd: String
    var dateStart: String
    var note: String
    var type: WhoAndWhom
    var currency: String
}
