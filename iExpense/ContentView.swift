//
//  ContentView.swift
//  iExpense
//
//  Created by Noalino on 16/11/2023.
//

import SwiftData
import SwiftUI

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
