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
            if businessExpenses.count > 0 {
                Section("Business") {
                    ForEach(businessExpenses) { item in
                        ExpenseItemView(item: item)
                    }
                    .onDelete(perform: { offsets in
                        removeExpenses(at: offsets, from: businessExpenses)
                    })
                }
            }
            
            if personalExpenses.count > 0 {
                Section("Personal") {
                    ForEach(personalExpenses) { item in
                        ExpenseItemView(item: item)
                    }
                    .onDelete(perform: { offsets in
                        removeExpenses(at: offsets, from: personalExpenses)
                    })
                }
            }
        }
    }

    init(filterType: String, sortOrder: [SortDescriptor<Expense>]) {
        let types = Expense.types
        _expenses = Query(filter: #Predicate<Expense> { expense in
            !types.contains(filterType) || expense.type == filterType
        }, sort: sortOrder)
    }

    func removeExpenses(at offsets: IndexSet, from expenses: [Expense]) {
        for index in offsets {
            modelContext.delete(expenses[index])
        }
    }
}

#Preview {
    ExpensesView(filterType: "All", sortOrder: [SortDescriptor(\Expense.name)])
}
