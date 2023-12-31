//
//  Expense.swift
//  iExpense
//
//  Created by Noalino on 01/12/2023.
//

import Foundation
import SwiftData

@Model
class Expense {
    static var types = ["Business", "Personal"]
    
    var name: String
    var type: String
    var amount: Double

    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
