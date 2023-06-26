//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Fauzan Dwi Prasetyo on 26/06/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var newOrder: NewOrder
    
    @State private var titleAlert = ""
    @State private var messageAlert = ""
    @State private var showingAlert = false
    
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
                    Text("\(newOrder.order.cost, format: .currency(code: "USD"))")
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
        .alert(titleAlert, isPresented: $showingAlert) {
            Button("OK") {}
        } message: {
            Text(messageAlert)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(newOrder.order) else {
            showAlert(title: "Error", message: "Failed to encoded order.")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decode = try JSONDecoder().decode(Order.self, from: data)
            showAlert(title: "Thank you!", message: "Your order for \(decode.quantity)x \(Order.types[decode.type]) cupcakes is on its way!")
        } catch {
            showAlert(title: "Error", message: "There is no internet connection.")
        }
    }
    
    // challenge 2
    func showAlert(title: String, message: String) {
        titleAlert = title
        messageAlert = message
        showingAlert = true
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(newOrder: NewOrder(order: Order()))
        }
    }
}
