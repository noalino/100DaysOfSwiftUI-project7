//
//  ContentView.swift
//  iExpense
//
//  Created by Noalino on 16/11/2023.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var filterType = "All"
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ]

    var body: some View {
        NavigationStack {
            ExpensesView(filterType: filterType, sortOrder: sortOrder)
                .navigationTitle("iExpense")
                .toolbar {
                    NavigationLink("Add expense") {
                        AddView()
                    }

                    Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                        Picker("Filter", selection: $filterType) {
                            Text("All")
                                .tag("All")

                            Text("Business")
                                .tag("Business")

                            Text("Personal")
                                .tag("Personal")
                        }
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
