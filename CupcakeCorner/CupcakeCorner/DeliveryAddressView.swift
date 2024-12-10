//
//  DeliveryAddressView.swift
//  CupcakeCorner
//
//  Created by Pallab Maiti on 21/11/24.
//

import SwiftUI

struct DeliveryAddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Flat, Building, Company, Apartment", text: $order.address1)
                TextField("Area, Street, Sector, Village", text: $order.address2)
                TextField("Landmark", text: $order.landmark)
                Picker("State", selection: $order.state) {
                    ForEach(order.states.indices, id: \.self) {
                        Text(order.states[$0])
                    }
                }
                Picker("City", selection: $order.city) {
                    ForEach(order.cities.indices, id: \.self) {
                        Text(order.cities[$0])
                    }
                }
                TextField("Pincode", text: $order.pincode)
                    .keyboardType(.decimalPad)
            }
            
            Section {
                NavigationLink {
                    
                } label: {
                    Text("Proceed to Checkout")
                }
            }
            .disabled(!order.hasValidAddress)
        }
        .navigationTitle("Delivery Address")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DeliveryAddressView(order: Order())
}
