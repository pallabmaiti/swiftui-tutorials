//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Pallab Maiti on 21/11/24.
//

import SwiftUI

struct CheckoutView: View {
    @Bindable var order: Order
    
    var body: some View {
        ScrollView {
            Text("Total cost: \(order.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    CheckoutView(order: Order())
}
