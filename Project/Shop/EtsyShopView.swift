//
//  HomeView.swift
//  Project
//
//  Created by Christian Hernandez on 10/3/24.
//
import SwiftUI
import JWTDecode

struct EtsyShopView: View {
    //retrieving an array of Products
    @State private var products: [Product] = []
    /* Specify which item type is currently selected/being viewed. */
    @State private var selectedItemType: String = "All Items"// this is the default selection of all items
    @State private var itemTypes: [String] = [
            "All Items",
            "Children Patterns",
            "Adult Patterns",
            "Pet Patterns",
            "Accessories Patterns",
            "Embroidery Files",
            "ITH Embroidery Files",
            "FSL Embroidery Files",
            "Applique Embroidery Files",
            "SVG/PNG Files",
            "Patches/Appliques/Lace",
            "Sweaters/Tees",
            "Tote Bags"
        ]
    
    var body: some View {
        //top of another layered so the background is white then on top we have our view
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            //this will allow me to scroll
            ScrollView {
                VStack {
                    /* Selection to pick item type to be displayed */
                    Picker("Select Item Type", selection: $selectedItemType) {
                        /* Get each corresponding item type */
                        ForEach(itemTypes, id: \.self) { itemType in
                            Text(itemType).tag(itemType)
                        }
                    }
                    .pickerStyle(MenuPickerStyle()) // Use a dropdown style
                    .padding()

                    // Fetch products based on selected item type
                    Button("Load Items") {
                        fetchProducts(for: selectedItemType)
                    }
                    .padding()
                    /* Display each item. */
                    ForEach(products, id: \.id) { product in
                        ProductView(product: product)
                    }
                }
                .offset(y: 60)
            }
        }
        .onAppear {
            // Fetch products when the view appears
            fetchProducts(for: selectedItemType)
        }
    }
    /* Prepare API fetch string. */
    private func fetchProducts(for itemType: String) {
        // Modify the API request based on the selected item type
        let url: String
            switch itemType {
            case "All Items":
                url = "/shop"
            case "Children Patterns":
                url = "/shop/childrenPatterns"
            case "Adult Patterns":
                url = "/shop/adultPatterns"
            case "Pet Patterns":
                url = "/shop/petPatterns"
            case "Accesories Patterns":
                url = "/shop/accesoriesPatterns"
            case "Embroidery Files":
                url = "/shop/embroideryFiles"
            case "ITH Embroidery Files":
                url = "/shop/ithEmbroideryFiles"
            case "FSL Embroidery Files":
                url = "/shop/fslEmbroideryFiles"
            case "Applique Embroidery Files":
                url = "/shop/appliqueEmbroideryFiles"
            case "SVG/PNG Files":
                url = "/shop/svgPngFiles"
            case "Patches/Appliques/Lace":
                url = "/shop/patchesAppliquesLace"
            case "Sweaters/Tees":
                url = "/shop/sweatersTees"
            case "Tote Bags":
                url = "/shop/toteBags"
            default:
                url = "/shop" // Default to fetching all items
            }
        getAllItems(url: url) { products in
            if let products = products {
                self.products = products // Update state with fetched products
            } else {
                print("Failed to fetch products.")
            }
        }
    }
}
/* API request to get specified items of type itemType. */
func getAllItems(url: String, completion: @escaping ([Product]?) -> Void) {
    ClientServer.shared.testLoad(url: url, method: "GET") { result in
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
            completion(nil)
        }
    }
}
//precondition: requires a unique identifier for each instance, which allows to distinguish one item from another-> using Identifiable
//postcondition: this struct that contains the product information such as name, price, and the image of the product
struct Product: Identifiable, Codable {
    //the id-> makes sure each user had its onw id, name,price,image->id
    var id: String
    var productName: String
    var productType: String
    var style: String
    var description: String
    var price: Double
    var mainImage: String
    var gallery: [String]
}

/* View for an individual product. */
struct ProductView: View {
    var product: Product
    /* manage loading items */
    @State private var isAddingToCart = false
    @State private var isUserLoggedIn = false // Track if the user is logged in
    @State private var showLoginAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.productName)
                .font(.headline)
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
            if let uiImage = loadImage(at: product.mainImage) {
                Image(uiImage: uiImage) // Convert UIImage to Image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200) // Set a fixed height for images
            } else {
                Text("Image not found")
                    .foregroundColor(.red)
            }
            Text(product.description)
                .font(.body)
                .lineLimit(3) // Limit the number of lines
            Divider() // Divider between products
            
            /* Add to cart button only if user is logged in */
            if isUserLoggedIn {
                Button(action: {
                    addToCart(product.id)
                }) {
                    Text("Add to Cart")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(isAddingToCart)
                .opacity(isAddingToCart ? 0.5 : 1.0)
            } else {
                Text("Please log in to add items to your cart.")
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
        }
        .padding()
        .onAppear {
            checkUserLoginStatus() // Check login status when the view appears
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
    
    /* Check if the user is logged in */
    private func checkUserLoginStatus() {
        if UserDefaults.standard.string(forKey: "authToken") != nil {
            isUserLoggedIn = true
        } else {
            isUserLoggedIn = false
        }
    }
    
    /* If user is logged in, allow them to add to cart. */
    private func addToCart(_ productId: String) {
        
        isAddingToCart = true
        
        /* Get the JWT of the authenticated user. */
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            print("User is not authenticated")
            isAddingToCart = false
            return
        }
        
        do {
            let jwt = try decode(jwt: token)
            if let userId = jwt["userId"].string {
                
                /* Now send API Request to add to the cart. */
                
                /* prepare the payload */
                let userPayload: [String: Any] = ["userId": userId]
                do {
                    let jwt = try decode(jwt: token)
                    
                    // Declare userId outside the if let scope
                    if let userId = jwt["userId"].string {
                        // Prepare the payload
                        let userPayload: [String: Any] = ["id": userId]
                        
                        // Now send API Request to add to the cart
                        ClientServer.shared.testLoad(url: "/addCart/\(productId)", method: "POST", payload: userPayload) { result in
                            // Reset the state after the API call completes
                            isAddingToCart = false
                            
                            switch result {
                            case .success(let responseString):
                                print("Response: \(responseString)")
                            case .failure(let error):
                                print("Error: \(error.localizedDescription)")
                            }
                        }
                    } else {
                        print("Failed to retrieve userId from JWT")
                        isAddingToCart = false // Reset state
                    }
                } catch {
                    print("Failed to decode JWT: \(error.localizedDescription)")
                    isAddingToCart = false // Reset state
                }
            }
        } catch {
            print("Error getting token: \(error.localizedDescription)")
        }
    }
}
