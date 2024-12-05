//
//  CheckoutView.swift
//  Project
//
//  Created by Isaiah Vogt on 12/4/24.
//

import Foundation
import SwiftUI
import JWTDecode

struct CheckOutView: View {
    /* Order object that was created after checkout button. */
    var orderData: Order
    
    /* If the order was succesfully placed, this is set to true and the view is redirected to the orders page. */
    @State private var isOrderPlaced = false
    /* order json object that is passed to the order view upon success. */
    @State private var orderPlaced: Order?
    var body: some View {
        ZStack{
            if isOrderPlaced {
                Text("Thank you for your purchase.")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .padding(.bottom)
            }
            else {
                //even if dark mode we want background to be white
                Color.white
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Checkout")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    // List of items
                    List(orderData.itemsOrdered) { item in
                        ItemCheckoutView(product: item)
                    }
                    
                    // Divider
                    Divider()
                    
                    // Total price display
                    Text("Total: $\(orderData.total, specifier: "%.2f")")
                        .font(.title)
                        .padding()
                    
                    // Place Order button
                    Button(action: {
                        placeOrder()
                    }) {
                        Text("Place Order")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
        }
    }
    private func placeOrder() {
        shipOrder(orderId: orderData.id) { placedOrder in
            DispatchQueue.main.async {
                if let placedOrder = placedOrder, placedOrder.orderStatus == "shipped" {
                    self.orderPlaced = placedOrder
                    self.isOrderPlaced = true
                } else {
                    print("Order shipment failed.\n")
                    self.isOrderPlaced = false
                }
            }
        }
    }
}

/* API request to submit order to shipped */
func shipOrder( orderId: String, completion: @escaping(Order?) -> Void) {
    /* Get the JWT of the authenticated user. */
    guard let token = UserDefaults.standard.string(forKey: "authToken") else {
        print("User is not authenticated")
        completion(nil) // Call completion with nil if not authenticated
        return
    }
    
    /* Begin the request */
    do {
        let jwt = try decode(jwt: token)
        if let userId = jwt["userId"].string {
            ClientServer.shared.testLoad(url: "/order/ship/\(orderId)", method: "POST") {
                result in
                
                switch result {
                case .success(let responseString):
                    if let data = responseString.data(using: .utf8) {
                        do {
                            let order = try JSONDecoder().decode(Order.self, from: data)
                            completion(order)
                        } catch {
                            print("Error decoding JSON: \(error.localizedDescription)")
                            completion(nil) // Return nil in case of error
                        }
                    } else {
                        print("Error converting response string to data")
                        completion(nil) // Return nil if conversion fails
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion(nil) // Call completion with nil on error
                }
                
            }
        } else {
            print("Failed to retrieve userId from JWT")
            completion(nil) // Call completion with nil if userId is not found
        }
    } catch {
        print("Failed to decode JWT: \(error.localizedDescription)")
        completion(nil) // Call completion with nil on error
    }
}

struct ItemCheckoutView: View {
    var product: Product
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.productName)
                .font(.headline)
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
            if let uiImage = loadImage(at: product.mainImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
            } else {
                Text("Image not found")
                    .foregroundColor(.red)
            }
            Text(product.description)
                .font(.body)
                .lineLimit(3)
            Divider()
        }
        .padding()
    }
    // Function to load an image from a file path
    private func loadImage(at imagePath: String) -> UIImage? {
        let documentPath = "/Users/isaiahvogt/Documents/411/FinalProject/Yesenia-Designs-App/"
        let imagePath = documentPath.appending(imagePath)
        guard let image = UIImage(contentsOfFile: imagePath) else {
            return nil
        }
        return image
    }
}
