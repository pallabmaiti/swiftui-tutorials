//
//  ContentView.swift
//  MyExpense
//
//  Created by Pallab Maiti on 15/11/24.
//

import SwiftUI

struct ExpenseItemView: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.date.formatted(.dateTime))
                    .font(.subheadline)
            }
            
            Spacer()
            
            Text("\(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                .font(.headline)
                .foregroundStyle(
                    item.amount.isLessThanOrEqualTo(100) ? Color.blue :
                        item.amount.isLessThanOrEqualTo(500) ? Color.orange : Color.red
                )
        }
    }
}

extension Collection {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}


struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showAddExpense: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                if (expenses.foodItems.isNotEmpty) {
                    Section("Food") {
                        ForEach(expenses.foodItems) { item in
                            ExpenseItemView(item: item)
                        }
                    }
                }
                
                if (expenses.travelItems.isNotEmpty) {
                    Section("Transportation") {
                        ForEach(expenses.travelItems) { item in
                            ExpenseItemView(item: item)
                        }
                    }
                }
                
                if (expenses.entertainmentItems.isNotEmpty) {
                    Section("Entertainment") {
                        ForEach(expenses.entertainmentItems) { item in
                            ExpenseItemView(item: item)
                        }
                    }
                }
                
                if (expenses.otherItems.isNotEmpty) {
                    Section("Other") {
                        ForEach(expenses.otherItems) { item in
                            ExpenseItemView(item: item)
                        }
                    }
                }
            }
            .navigationTitle("My Expenses")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showAddExpense.toggle()
                }
            }
            .sheet(isPresented: $showAddExpense) {
                AddExpenseView(expenses: expenses)
            }
        }
    }
}

#Preview {
    ContentView()
}
