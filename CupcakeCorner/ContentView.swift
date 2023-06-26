//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Fauzan Dwi Prasetyo on 25/06/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var newOrder = NewOrder(order: Order())
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $newOrder.order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(newOrder.order.quantity)", value: $newOrder.order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $newOrder.order.specialRequestEnabled.animation())
                    
                    if newOrder.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $newOrder.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $newOrder.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AdressView(newOrder: newOrder)
                    } label: {
                        Text("Delivery Details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
