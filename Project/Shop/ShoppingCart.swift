//
//  ShoppingCart.swift
//  Project
//
//  Created by Christian Hernandez on 11/20/24.
//

import Foundation
import SwiftUI
import JWTDecode

struct ShoppingCart: View {
    @State private var products: [Product] = [] // Array to hold products
    @State private var subtotal: Float = 0.0
    @State private var isLoading = true // State to manage loading state
    /* If the order was sucessfully created, this is set to true and the view is redirected to a checkout page. */
    @State private var isOrderSuccess = false
    /* order json object that is passed to the checkout view upon success. */
    @State private var order: Order?
    
    var body: some View {
        NavigationView {
            ZStack{
                
                //even if dark mode we want background to be white
                Color.white
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    if isLoading {
                        ProgressView() // Show a loading indicator while fetching data
                    } else if products.isEmpty {
                        // No items in the cart
                        VStack {
                            Text("0 items in your cart")
                                .foregroundColor(.black)
                            Text("Keep Shopping!:)")
                                .foregroundColor(.gray)
                        }
                    } else {
                        // Display subtotal and checkout button
                        VStack {
                            HStack {
                                Text("Subtotal: \(subtotal, specifier: "%.2f")")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                /* This triggers an api request to set the cart status to checkedout, which subsequently creates an order object from the cart and the cart object is destroyed. */
                                Button(action: {
                                    // Action for checkout
                                    checkOutCart()
                                }) {
                                    Text("Checkout")
                                        .font(.headline)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                            .padding()
                            
                            // Display the list of products
                            List(products) { product in
                                ItemView(product: product) {
                                    fetchCartItems()
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    fetchCartItems() // Fetch cart items when the view appears
                }
                // Navigation link to CheckOutView
                if let order = order {
                    NavigationLink(destination: CheckOutView(orderData: order), isActive: $isOrderSuccess) {
                        EmptyView() // This is a hidden link that activates when isOrderSuccess is true
                    }
                }
            }
        }
    }
    
    /* Create an order. */
    private func checkOutCart() {
        createOrder() { order in
            DispatchQueue.main.async {
                print("Returned status: \(order?.orderStatus ?? "nil")\n")
                if let order = order, order.orderStatus == "checkedout" {
                    self.order = order // Set the order if successful
                    self.isOrderSuccess = true // Trigger navigation
                } else {
                    print("Order creation failed.\n")
                    self.isOrderSuccess = false // Keep it false if failed
                }
            }
        }
    }
    
    private func fetchCartItems() {
        let url = "/cart/" // Replace with your actual API endpoint
        getUserCartItems(url: url) { cart in
            DispatchQueue.main.async {
                self.products = cart?.items ?? [] // Update products state
                self.subtotal = cart?.subtotal ?? 0.0
                self.isLoading = false // Set loading to false
            }
        }
    }
}

/* Used for retrieving the status of the api request */
//struct Status: Identifiable, Codable {
//    var id: String
//    var status: String
//}

struct Order: Identifiable, Codable {
    var id: String
    var username: String
    var itemsOrdered: [Product]
    var total: Double
    var placementDate: String
    var orderStatus: String
}

/* API request to create an order from a user's cart. */
func createOrder( completion: @escaping (Order?) -> Void) {
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
            ClientServer.shared.testLoad(url: "/order/\(userId)", method: "POST") {
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

/* Used for retrieving and maintaining user's cart. */
struct Cart: Identifiable, Codable {
    var id: String
    var items: [Product]
    var username: String
    var subtotal: Float
}

/* API request to get a user's cart. */
func getUserCartItems(url: String, completion: @escaping (Cart?) -> Void) {
    /* Get the JWT of the authenticated user. */
    guard let token = UserDefaults.standard.string(forKey: "authToken") else {
        print("User is not authenticated")
        completion(nil) // Call completion with nil if not authenticated
        return
    }
    
    do {
        let jwt = try decode(jwt: token)
        if let userId = jwt["userId"].string {
            ClientServer.shared.testLoad(url: "/cart/\(userId)", method: "GET") { result in
                switch result {
                case .success(let responseString):
                    //print("Response: \(responseString)")
                    if let data = responseString.data(using: .utf8) {
                        do {
                            // Decode as an array of Product
                            let cart = try JSONDecoder().decode(Cart.self, from: data)
                            completion(cart) // Return the products
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

struct ItemView: View {
    var product: Product
    @State private var isRemovingFromCart = false
    /* Closure that allows for refreshing of view when Item is removed. */
    var onRemove: () -> Void
    
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
            
            /* TODO: Remove from cart */
            Button(action: {
                removeFromCart(product.id)
            }) {
                Text("Remove")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(isRemovingFromCart)
            .opacity(isRemovingFromCart ? 0.5 : 1.0)
        }
        .padding()
    }
    /* Function to remove item from cart. */
    private func removeFromCart(_ productId: String) {
        isRemovingFromCart = true
        
        /* Get the JWT of the authenticated user. */
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            print("User is not authenticated")
            isRemovingFromCart = false
            return
        }
        
        do {
            let jwt = try decode(jwt: token)
            if let userId = jwt["userId"].string {
                
                /* Now send API Request to remove from the cart. */
                let userPayload: [String: Any] = ["userId": userId]
                do {
                    let jwt = try decode(jwt: token)
                    
                    // Declare userId outside the if let scope
                    if let userId = jwt["userId"].string {
                        // Prepare the payload
                        let userPayload: [String: Any] = ["id": userId]
                        
                        /* Now send the API request to remove from cart. */
                        ClientServer.shared.testLoad(url: "/removeCart/\(productId)", method: "DELETE", payload: userPayload) { result in
                            isRemovingFromCart = false
                            
                            switch result {
                            case .success(let responseString):
                                print("Response: \(responseString)")
                                /* Notify ShoppingCart to refresh its view. */
                                onRemove()
                            case .failure(let error):
                                print("Error: \(error.localizedDescription)")
                            }
                        }
                    } else {
                        print("Failed to retrieve user id from JWT.")
                        isRemovingFromCart = false
                    }
                } catch {
                    print("Failed to decode JWT: \(error.localizedDescription)")
                    isRemovingFromCart = false
                }
            }
        } catch {
            print("Error getting token: \(error.localizedDescription)")
        }
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

