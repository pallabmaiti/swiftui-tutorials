//
//  Expenses.swift
//  LearningSwiftUI
//
//  Created by Pallab Maiti on 15/11/24.
//

import Foundation
import Observation

enum ExpenseType: String, CaseIterable, Codable {
    case food = "Food", entertainment = "Entertainment", travel = "Travel", other = "Other"
}

struct ExpenseItem: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let amount: Double
    let date: Date
    let type: ExpenseType
}

@Observable
class Expenses {
    private var items: [ExpenseItem] {
        didSet {
            if let data = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(data, forKey: "Expenses")
            }
        }
    }
    
    var foodItems: [ExpenseItem] {
        items.filter{ $0.type == .food }
    }
    
    var entertainmentItems: [ExpenseItem] {
        items.filter{ $0.type == .entertainment }
    }
    
    var travelItems: [ExpenseItem] {
        items.filter{ $0.type == .travel }
    }
    
    var otherItems: [ExpenseItem] {
        items.filter{ $0.type == .other }
    }
    
    init () {
        if let data = UserDefaults.standard.data(forKey: "Expenses") {
            if let decode = try? JSONDecoder().decode([ExpenseItem].self, from: data) {
                items = decode
                return
            }
        }
        items = []
    }
    
    func add(_ item: ExpenseItem) {
        items.append(item)
    }
}
