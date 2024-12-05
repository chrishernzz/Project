//
//  BlogView.swift
//  Project
//
//  Created by Christian Hernandez on 12/3/24.
//

import SwiftUI

struct BlogView: View {
    var body: some View {
        //top of another layered so the background is white then on top we have our view
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                //this allows user to scroll up and down
                ScrollView {
                    LinearGradient(
                        gradient: Gradient(colors: [Color(red: 1.0, green: 0.94, blue: 0.96), Color.white]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, -16)
                    Text("BLOG")
                        .font(.custom("Lora-Bold", size: 35))
                    //RGB color
                        .foregroundColor(Color(red: 0.9, green: 0.39, blue: 0.64))
                        .padding(.top, -100)
                        .padding(.bottom, 25)
                    VStack(alignment: .leading, spacing: 20) {
                        //call the main page that has all the vlog information
                        MainBlogPage()
                    }
                    .padding(.leading, -150)
                    .padding(.top, -30)
                    .padding(.bottom, 30)
                    //reuse the struct that you created that goes after all the information
                    InformationAfterImages()
                }
            }
        }
    }
}
