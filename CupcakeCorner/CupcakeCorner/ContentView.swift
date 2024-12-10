//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Pallab Maiti on 21/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Cupcake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Quantity: \(order.quantity)", value: $order.quantity, in: 1...10)
                }
                
                Section {
                    Toggle("Special request?", isOn: $order.specialRequestEnabled)
                    if order.specialRequestEnabled {
                        Toggle("Extra frosting?", isOn: $order.extraFrosting)
                        Toggle("Add sprinkles?", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        DeliveryAddressView(order: order)
                    } label: {
                        Text("Delivery address")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
