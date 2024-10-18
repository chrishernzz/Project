//
//  HomeView.swift
//  Project
//
//  Created by Christian Hernandez on 10/3/24.
//
import SwiftUI

//struct that contains the product information such as name, price, and the image of the product
struct Product: Identifiable {
    //the id-> makes sure each user had its onw id, name,price,image->id
    var id: Int
    var name: String
    var price: Double
    var image: String
}

struct EtsyShopView: View {
    //creating an array of Product for testing
    let productsInformation: [Product] = [
        Product(id: 1, name: "PDF Dinosour Poncho Sewing Pattern Kids Youth Sizes M-XL", price: 14.0, image: "dinosourimage"),
        Product(id: 2, name: "PDF Butterfly Bug Cape Sewing Pattern Kids Sizes 2T-6", price: 16.0, image: "butterflybugimage"),
        Product(id: 3, name: "PDF Adult Spiderweb Poncho Sewing Pattern Sizes XS-XL", price: 10.0, image: "spiderwebimage"),
        Product(id: 4, name: "PDF Reversible Dog Collar Bandana Sewing Pattern Sizees XS-XL", price: 3.0, image: "reversibledogimage"),
    ]

    var body: some View {
        //top of another layered so the background is white then on top we have our view
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            //lets me slide the images side to side
            TabView {
                //loop through the array , index[0] -> etc
                ForEach(productsInformation) { product in
                    VStack(spacing: 5) {
                        // Add a rounded rectangle to create the box for the product content
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white) // Light background for the box
                            .frame(height: 350) // Adjust height based on content
                            .overlay(
                                //vertical-> this lets image,Text->'Featured Item', name,price, and button->'Shop Now' (top to bottom)
                                VStack(spacing: 5) {
                                    //larger product image with size adjusted to fit
                                    Image(product.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 220, height: 220) // Increased image size
                                        .cornerRadius(12)
                                    
                                    //simple text that states "featured item"
                                    Text("FEATURED ITEM")
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                        .padding(.bottom, 5)
                                    
                                    //going to print out the name and price in vertical axis
                                    VStack(alignment: .center) {
                                        //adjust product name to fit two lines properly
                                        Text(product.name)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)  // Explicitly set text color to black
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2) // Ensures the text fits in two lines
                                            .fixedSize(horizontal: false, vertical: true) // Allows the text to wrap properly
                                            .padding(.horizontal, 5)
                                        //now print the price
                                        Text("$\(product.price, specifier: "%.2f")")
                                            .font(.subheadline)
                                            .foregroundColor(.black)

                                        //creating a button for shop now
                                        Button(action: {
                                            //put the code you want here after user clicks on 'Shop Now'
                                        }) {
                                            Text("SHOP NOW")
                                                .padding(.vertical, 10)
                                                .padding(.horizontal, 10)
                                                .background(Color.pink.opacity(0.2))
                                                .cornerRadius(3)
                                        }
                                        //creating space between price and button
                                        .padding(.top, 10)
                                    }
                                }
                            )
                    }
                }
            }
            //this is for dots, placing it after the content to avoid overlap
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .accentColor(Color.black.opacity(1.5))
            .frame(height: 400)
            
            //offset will allow me to move the items up without cropping any photos
            .offset(y: -120)
        }
        .navigationTitle("Shop")
    }
}

//lets me see the updates (just a preview of the code you are doing)
struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        EtsyShopView()
    }
}

