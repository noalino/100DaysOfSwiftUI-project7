//
//  ContentView.swift
//  iExpense
//
//  Created by Noalino on 16/11/2023.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

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
    let item: ExpenseItem

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
    @State private var expenses = Expenses()

    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses.items.filter { $0.type == "Personal" }) { item in
                        ExpenseItemView(item: item)
                    }
                    .onDelete(perform: removeItems)
                }

                Section("Business") {
                    ForEach(expenses.items.filter { $0.type == "Business" }) { item in
                        ExpenseItemView(item: item)
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
//                Button("Add Expense", systemImage: "plus") {
////                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
////                    expenses.items.append(expense)
//                    showingAddExpense = true
//                }
                NavigationLink("Add expense") {
                    AddView(expenses: expenses)
                }
            }
//            .sheet(isPresented: $showingAddExpense) {
//                AddView(expenses: expenses)
//            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
