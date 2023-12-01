//
//  ContentView.swift
//  iExpense
//
//  Created by Noalino on 16/11/2023.
//

import SwiftData
import SwiftUI

struct AmountFormat: ViewModifier {
    let amount: Double

    func body(content: Content) -> some View {
        content
            .font(amount < 10 ? .title : amount < 100 ? .title2 : .title3)
    }
}

extension View {
    func amountFormat(amount: Double) -> some View {
        modifier(AmountFormat(amount: amount))
    }
}

struct ExpenseItemView: View {
    let item: Expense

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)

                Text(item.type)
            }

            Spacer()

            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                .amountFormat(amount: item.amount)
        }
    }
}

struct ContentView: View {
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ]

    var body: some View {
        NavigationStack {
            ExpensesView(sortOrder: sortOrder)
                .navigationTitle("iExpense")
                .toolbar {
                    NavigationLink("Add expense") {
                        AddView()
                    }

                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\Expense.name),
                                    SortDescriptor(\Expense.amount)
                                ])

                            Text("Sort by Amount")
                                .tag([
                                    SortDescriptor(\Expense.amount),
                                    SortDescriptor(\Expense.name)
                                ])
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
