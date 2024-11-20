//
//  AddExpenseView.swift
//  LearningSwiftUI
//
//  Created by Pallab Maiti on 15/11/24.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    @State var amount: Double = 0
    @State var expenseType: ExpenseType = .food
    @State var date: Date = Date()
    
    var expenses: Expenses
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("Name")
                    Spacer()
                    TextField("Lunch, Dinner, etc.", text: $name)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Amount")
                    Spacer()
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Expense Type")
                    Spacer()
                    Picker("Expense Type", selection: $expenseType) {
                        ForEach(ExpenseType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .labelsHidden()
                }
                DatePicker("Date", selection: $date)
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    expenses.add(.init(name: name, amount: amount, date: date, type: expenseType))
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddExpenseView(expenses: Expenses())
}
