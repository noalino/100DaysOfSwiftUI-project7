//
//  AddView.swift
//  iExpense
//
//  Created by Noalino on 16/11/2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = "Expense"
    @State private var type = "Personal"
    @State private var amount = 0.0

    var expenses: Expenses

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
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
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
    AddView(expenses: Expenses())
}
