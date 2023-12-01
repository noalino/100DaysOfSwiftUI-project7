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

    @Query var expenses: [Expense]

    @State private var name = "Expense"
    @State private var type = "Personal"
    @State private var amount = 0.0

    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(Expense.types, id: \.self) {
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
    AddView()
}
