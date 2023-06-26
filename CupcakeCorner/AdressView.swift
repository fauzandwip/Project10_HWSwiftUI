//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Fauzan Dwi Prasetyo on 26/06/23.
//

import SwiftUI

struct AdressView: View {
    @ObservedObject var newOrder: NewOrder
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $newOrder.order.name)
                TextField("Street Adress", text: $newOrder.order.streetAdress)
                TextField("City", text: $newOrder.order.city)
                TextField("Zip", text: $newOrder.order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(newOrder: newOrder)
                } label: {
                    Text("Checkout")
                }
            }
            .disabled(!newOrder.order.hasValidAdress)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AdressView(newOrder: NewOrder(order: Order()))
        }
    }
}
