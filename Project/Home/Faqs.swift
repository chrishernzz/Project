//
//  Faqs.swift
//  Project
//
//  Created by Christian Hernandez on 12/4/24.
//


import SwiftUI

struct Faqs: View {
    //create an array of URLs
    @State private var videoArray: [URL] = [
        URL(string: "https://www.youtube.com/embed/pkDgBO9PA-U")!
    ]
    @State private var currentlyExpanded: String?
    var body: some View{
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            VStack{
                Image("shopfrontcover")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal,5)
                VStack(alignment: .leading) {
                    VStack(spacing: -10) {
                        HStack {
                            Text("HOW TO ACCESS AND DOWNLOAD FILE")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(.leading)
                            //using spacer to cover all the space side to side
                            Spacer()
                            Button(action: {
                                if (currentlyExpanded == "HOW TO ACCESS AND DOWNLOAD FILE") {
                                    currentlyExpanded = nil
                                }
                                //this will run first since the currentlyExpanded is nil
                                else {
                                    //set it to the title
                                    currentlyExpanded = "HOW TO ACCESS AND DOWNLOAD FILE"
                                }
                            }) {
                                //this is a ternary if true then run minus false run plus
                                Image(systemName: currentlyExpanded == "HOW TO ACCESS AND DOWNLOAD FILE" ? "minus" : "plus")
                                    .foregroundColor(.gray)
                                    .padding(.trailing)
                            }
                        }
                        .frame(height: 50)
                        .background(Color.pink.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                        if(currentlyExpanded == "HOW TO ACCESS AND DOWNLOAD FILE") {
                            HStack{
                                ForEach(videoArray, id: \.self) {item in
                                    WebView(url: item)
                                        .frame(height: 150)
                                        .padding(.horizontal, 12)
                                        .padding(.bottom, 50)
                                }
                            }
                            .padding(.leading, 5)
                            .padding(.trailing, 5)
                            .padding(.bottom, -50)
                        }
                    }
                }
            }
        }
    }
}


