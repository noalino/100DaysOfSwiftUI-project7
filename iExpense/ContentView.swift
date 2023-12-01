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
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]

    var personalExpenses: [Expense] {
        expenses.filter { $0.type == "Personal" }
    }

    var businessExpenses: [Expense] {
        expenses.filter { $0.type == "Business" }
    }

    var body: some View {
        NavigationStack {
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
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink("Add expense") {
                    AddView(expenses: expenses)
                }
            }
        }
    }

    func removeExpenses(at offsets: IndexSet, from expenses: [Expense]) {
        for index in offsets {
            modelContext.delete(expenses[index])
        }
    }
}

#Preview {
    ContentView()
}
