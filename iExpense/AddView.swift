//
//  AddView.swift
//  iExpense
//
//  Created by Noalino on 16/11/2023.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State private var name = "Expense"
    @State private var type = "Personal"
    @State private var amount = 0.0

    var expenses: [Expense]

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                Button("Save") {
                    let item = Expense(name: name, type: type, amount: amount)
                    modelContext.insert(item)
                    dismiss()
                }
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    let expense1 = Expense(name: "Expense 1", type: "Personal", amount: 10)
    let expense2 = Expense(name: "Expense 2", type: "Business", amount: 150)
    return AddView(expenses: [expense1, expense2])
        .modelContainer(for: Expense.self)
}
