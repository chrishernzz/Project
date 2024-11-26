//
//  FAQSShop.swift
//  Project
//
//  Created by Daniel Hernandez on 11/25/24.
//

import SwiftUI

struct FAQSShop: View {
    var body: some View {
        ZStack{
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color.pink.opacity(0.2), Color.white]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, -16)
                    Text("FAQS")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.pink)
                        .padding(.top, -100)
                    //this will display first since we are doing VStack-> topt to bottom
                    Image("shopfrontcover")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.bottom, -10)
                    //adds a straight line
                    Divider()
                        .frame(width: 350, height: 1)
                        .background(Color.gray)
                        .padding(.top, 25)
                    Text("How to Access & Download Digital \n\t\t\t\t  File")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .padding(.top,25)
                    //reusing this struct that was created earlier
                    InformationAfterImages()
                }
            }
        }
    }
}

//shows the final preview of all the structs combined
struct FAQSShop_Preview: PreviewProvider {
    static var previews: some View {
        FAQSShop()
    }
}
