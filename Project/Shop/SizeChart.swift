//
//  SizeChart.swift
//  Project
//
//  Created by Christian Hernandez on 11/27/24.
//

import SwiftUI

struct SizeChart: View {
    var url: URL
    //can pass this-> won't be refer as a parameter
    @Environment(\.openURL) var openurl
    var body: some View {
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            ScrollView {
                //this will start off white and then
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.2), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, -16)
                //top to bottom-> vertical that gets the images then the link
                VStack {
                    Text("SIZE CHART INFO")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.pink)
                        .padding(.top, -100)
                        .padding(.bottom, 25)
                    //now the images go here
                    Image("shoppingimage1")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                    Text("Fabric panel is per size and you'll need 1 yard (Print on cotton fabric)")
                        .foregroundColor(.pink)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Image("shoppingimage2")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                    Text("Fabric panel is per size and you'll need")
                        .foregroundColor(.pink)
                    Text("1 yard for size XS")
                        .foregroundColor(.black)
                    Text("1 yard for size S")
                        .foregroundColor(.black)
                    Text("2 yards for size M")
                        .foregroundColor(.black)
                    Text("Print on cotton fabric")
                        .foregroundColor(.pink)
                    
                    //now need to create a button
                    Button(action: {
                        //open the URL here once the button is pressed
                        openurl(url)
                    }){
                        Text("SHOP NOW")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .background(Color.black)
                            .cornerRadius(5)
                            .padding(.top, 30)
                    }
                    
                }
                //make sure there is space in the bottom betweent the vstack and the information that goes after
                .padding(.bottom, 20)
                //call the struct that you created-> reusing
                InformationAfterImages()
            }
        }
    }
}
