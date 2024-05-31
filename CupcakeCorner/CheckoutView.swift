//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Om Preetham Bandi on 5/31/24.
//

import SwiftUI

struct CheckoutView: View {
    @Bindable var order: Order
    
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Section {
                    Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                        .font(.title)
                }
                
                Button("Place Order", action: {
                    Task {
                        await placeOrder()
                    }
                })
                      .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert(confirmationTitle, isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var requests = URLRequest(url: url)
        requests.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        requests.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: requests, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationTitle = "Thank You!"
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
            
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            confirmationTitle = "Oops!!"
            confirmationMessage = "Order failed to send! Please try again."
            showingConfirmation = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
