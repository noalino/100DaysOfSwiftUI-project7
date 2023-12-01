//
//  ExpensesView.swift
//  iExpense
//
//  Created by Noalino on 01/12/2023.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]

    var personalExpenses: [Expense] {
        expenses.filter { $0.type == "Personal" }
    }

    var businessExpenses: [Expense] {
        expenses.filter { $0.type == "Business" }
    }
    
    var body: some View {
        List {
            Section("Personal") {
                ForEach(personalExpenses) { item in
                    ExpenseItemView(item: item)
                }
                .onDelete(perform: { offsets in
                    removeExpenses(at: offsets, from: personalExpenses)
                })
            }

            Section("Business") {
                ForEach(businessExpenses) { item in
                    ExpenseItemView(item: item)
                }
                .onDelete(perform: { offsets in
                    removeExpenses(at: offsets, from: businessExpenses)
                })
            }
        }
    }

    init(sortOrder: [SortDescriptor<Expense>]) {
        _expenses = Query(sort: sortOrder)
    }

    func removeExpenses(at offsets: IndexSet, from expenses: [Expense]) {
        for index in offsets {
            modelContext.delete(expenses[index])
        }
    }
}

#Preview {
    ExpensesView(sortOrder: [SortDescriptor(\Expense.name)])
}
