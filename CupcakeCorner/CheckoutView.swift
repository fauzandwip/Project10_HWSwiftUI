//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Fauzan Dwi Prasetyo on 26/06/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .padding(.horizontal, 20)
                
                HStack {
                    Text("Your total is")
                        .font(.title)
                    Text("\(order.cost, format: .currency(code: "USD"))")
                        .font(.title)
                        .foregroundColor(.mint)
                }
                
                Button("Place Order", action: {})
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .padding()
                    .background(.mint)
                    .clipShape(Capsule())
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(order: Order())
        }
    }
}
