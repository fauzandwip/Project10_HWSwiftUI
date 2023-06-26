//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Fauzan Dwi Prasetyo on 26/06/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
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
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .font(.headline.bold())
                .foregroundColor(.white)
                .padding()
                .background(.mint)
                .clipShape(Capsule())
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encoded order.")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decode = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decode.quantity)x \(Order.types[decode.type]) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Failed checkout, \(error)")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(order: Order())
        }
    }
}
