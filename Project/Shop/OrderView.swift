//
//  OrderView.swift
//  Project
//
//  Created by Isaiah Vogt on 12/5/24.
//

import Foundation
import SwiftUI
import JWTDecode

struct OrderView: View {
    /* Shipped order json */
    @State private var placedOrders: [Order] = []
    var body: some View {
        ZStack {
            //even if dark mode we want background to be white
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                if placedOrders.isEmpty {
                    VStack {
                        Text("0 items ordered.")
                            .foregroundColor(.black)
                        Text("Keep Shopping!:)")
                            .foregroundColor(.gray)
                    }
                } else {
                    //even if dark mode we want background to be white
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("Checkout")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        // List of items
                        List(placedOrders) { order in
                            ShippedOrderView(shippedOrder: order)
                        }
                    }
                }
            }
            .onAppear {
                getPlacedOrders()
            }
        }
    }
    
    private func getPlacedOrders() {
        fetchPlacedOrders() { orders in
            if let orders = orders {
                self.placedOrders = orders
            } else {
                print("Failed to fetch orders.")
            }
        }
    }
}

func fetchPlacedOrders(completion: @escaping ([Order]?) -> Void) {
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
            ClientServer.shared.testLoad(url: "/orders/\(userId)", method: "GET") { result in
                
                switch result {
                case .success(let responseString):
                    if let data = responseString.data(using: .utf8) {
                        do {
                            let orders = try JSONDecoder().decode([Order].self, from: data) // Decode as an array of Product
                            completion(orders) // Return the products
                        } catch {
                            print("Error decoding JSON: \(error.localizedDescription)")
                            print("Raw JSON data: \(responseString)") // Print raw JSON for debugging
                            completion(nil) // Return nil in case of error
                        }
                    } else {
                        print("Error converting response string to data")
                        completion(nil) // Return nil if conversion fails
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion(nil)
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

struct ShippedOrderView: View {
    var shippedOrder: Order
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(formatDate(shippedOrder.placementDate))
                .font(.headline)
            Text("$\(shippedOrder.total, specifier: "%.2f")")
                .font(.subheadline)
            Text("Number of items: \(shippedOrder.itemsOrdered.count)")
                .font(.body)
                .lineLimit(3)
            Divider()
        }
        .padding()
    }
    private func formatDate(_ dateString: String) -> String {
            let dateFormatter = ISO8601DateFormatter() // Use ISO8601DateFormatter for your date format
            guard let date = dateFormatter.date(from: dateString) else {
                return "Invalid date" // Handle the case where the date string is invalid
            }

            // Now format the date for display
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
    }
}
