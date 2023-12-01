//
//  ExpenseItemView.swift
//  iExpense
//
//  Created by Noalino on 01/12/2023.
//

import SwiftUI

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

#Preview {
    ExpenseItemView(item: Expense(name: "Expense 1", type: "Personal", amount: 10))
}
