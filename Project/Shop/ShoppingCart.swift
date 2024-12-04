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
    @State private var isLoading = true // State to manage loading state
    var body: some View {
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
                        HStack {
                            Text("0 items in your cart")
                                .foregroundColor(.black)
                            Text("close")
                                .foregroundColor(.gray)
                        }
                        Text("Keep Shopping!:)")
                            .foregroundColor(.gray)
                    }
                } else {
                    // Display the list of products
                    List(products) { product in
                        ItemView(product: product)
                    }
                }
            }
            .onAppear {
                fetchCartItems() // Fetch cart items when the view appears
            }
        }
    }
                
    private func fetchCartItems() {
        let url = "/cart/" // Replace with your actual API endpoint
        getUserCartItems(url: url) { fetchedProducts in
            DispatchQueue.main.async {
                self.products = fetchedProducts ?? [] // Update products state
                self.isLoading = false // Set loading to false
            }
        }
    }
}

/* API request to get a user's cart. */
func getUserCartItems(url: String, completion: @escaping ([Product]?) -> Void) {
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
                            let products = try JSONDecoder().decode([Product].self, from: data) // Decode as an array of Product
                            completion(products) // Return the products
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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.productName)
                .font(.headline)
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
            if let uiImage = loadImage(from: product.mainImage) {
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
    // TODO: Why doesn't this work
    private func loadImage(from imagePath: String) -> UIImage? {
        let fileURL = URL(fileURLWithPath: imagePath)
        return UIImage(contentsOfFile: fileURL.path)
    }
}

//func parseProducts(from responseString: String) -> [Product]? {
//    // Convert the response string to Data
//    guard let data = responseString.data(using: .utf8) else {
//        print("Failed to convert response string to Data")
//        return nil
//    }
//    
//    do {
//        // Decode the JSON data into an array of Product
//        let products = try JSONDecoder().decode([Product].self, from: data)
//        return products
//    } catch {
//        print("Failed to decode JSON: \(error.localizedDescription)")
//        return nil
//    }
//}
