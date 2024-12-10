//
//  Order.swift
//  CupcakeCorner
//
//  Created by Pallab Maiti on 21/11/24.
//

import Foundation
import Helpers

@Observable
class Order: Codable {
    static var types = ["Vanilla", "Chocolate", "Strawberry", "Blueberry"]
    static var statesFromJSON: [String: [String]] = Bundle.main.decode(from: "states.json")
    
    var type = 0
    var quantity = 1
    
    var specialRequestEnabled: Bool = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting: Bool = false
    var addSprinkles: Bool = false
    
    var address1: String = ""
    var address2: String = ""
    
    var states: [String] {
        Self.statesFromJSON.map { key, value in
            return key
        }
        .sorted()
    }
    var state = 0 {
        didSet {
            city = 0
        }
    }
    
    var cities: [String] {
        Self.statesFromJSON[states[state]] ?? []
    }
    var city = 0
    
    var pincode = ""
    var landmark: String = ""
    
    var hasValidAddress: Bool {
        if address1.isEmpty || address2.isEmpty || pincode.isEmpty || pincode.count != 6 { return false }
        return true
    }
    
    var cost: Decimal {
        var cost: Decimal = 0
        
        switch type {
        case 0: cost += 100
        case 1: cost += 150
        case 2: cost += 200
        case 3: cost += 250
        default: cost += 0
        }
        
        // add quantity
        cost *= Decimal(quantity)
        
        // extra frosting
        if extraFrosting {
            cost += 100
        }
        
        // add sprinkles
        if addSprinkles {
            cost += 100
        }
        
        return cost
    }
}

extension Collection {
    var isNotEmpty: Bool { !isEmpty }
}
