//
//  HomeView.swift
//  Project
//
//  Created by Christian Hernandez on 10/3/24.
//
import SwiftUI

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
            
            //call the function here for the preview
            ProductFirstCarousel(products: productsInformation)
            //offset will allow me to move the items up without cropping any photos
                .offset(y: -120)
        }
        
        /* API Request */
        .onAppear{ClientServer.shared.testLoad(url: "/hello", method: "GET")}
        //.navigationTitle("Shop")
    }
}
//precondition: requires a unique identifier for each instance, which allows to distinguish one item from another-> using Identifiable
//postcondition: this struct that contains the product information such as name, price, and the image of the product
struct Product: Identifiable {
    //the id-> makes sure each user had its onw id, name,price,image->id
    var id: Int
    var name: String
    var price: Double
    var image: String
}
//precondition:
//postcondition:
struct ProductFirstCarousel: View {
    let products: [Product]
    @State private var currentIndex = 0
    var body: some View {
        VStack {
            //have to keep track of the index for the tabview update
            TabView(selection: $currentIndex) {
                //loop through the array , index[0] -> etc
                ForEach(products.indices, id: \.self) { index in
                    VStack(spacing: 5) {
                        Button(action: {
                            //here should take you to the option of the sale if they click on image
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(height: 350)
                                .overlay(
                                    //top to bottom with a 5 space in between vertically
                                    VStack(spacing: 5) {
                                        //now you have to pass in the index and pass in the product you are passing using the '.' gives you access to the struct
                                        Image(products[index].image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 220, height: 220)
                                            .cornerRadius(12)
                                        Text("FEATURED ITEM")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)
                                            .padding(.bottom, 5)
                                        //product and name are centered so pass in another VStack
                                        VStack(alignment: .center) {
                                            Text(products[index].name)
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                                .multilineTextAlignment(.center)
                                                .lineLimit(2)
                                                .fixedSize(horizontal: false, vertical: true)
                                                .padding(.horizontal, 5)
                                            Text("$\(products[index].price, specifier: "%.2f")")
                                                .font(.subheadline)
                                                .foregroundColor(.black)

                                            //creating a button if user clicks on shop now
                                            Button(action: {
                                                //this takes you to the image you are currently in
                                            }) {
                                                Text("SHOP NOW")
                                                    .padding(.vertical, 10)
                                                    .padding(.horizontal, 10)
                                                    .background(Color.pink.opacity(0.2))
                                                    .foregroundColor(Color.black)
                                                    .cornerRadius(3)
                                            }
                                            .padding(.top, 10)
                                        }
                                    }
                                )
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 400)
            //the dots are going to be side to side-> horizontal
            HStack {
                ForEach(products.indices, id: \.self) { index in
                    Button(action: {
                        //now need to flag it back to the index
                        currentIndex = index
                    }) {
                        Circle()
                            //using ternary operator meaning if it is equal then true else the color will be gray
                            .fill(currentIndex == index ? Color.pink.opacity(0.5) : Color.gray)
                            .frame(width: 10, height: 10)
                            .padding(4)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.bottom, 10)
        }
        .padding(.top, 10)
    }
}


//lets me see the updates (just a preview of the code you are doing)
struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        EtsyShopView()
    }
}

