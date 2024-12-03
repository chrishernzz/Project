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
                        //call the first video blog
                        FirstBlogVideo()
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
//precondition: NONE
//postcondition: this struct will indicate the first video and has options to click on comments and write comments as well
struct FirstBlogVideo: View {
    //allows the UI to change-> will only be access within this view
    @State private var isHovered = false
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Vlog: Darts on Board Final Project (Dart Manipulation on Front Bodice)")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.leading, 170)
            HStack (spacing: 5) {
                Text("11/30/2024")
                    .foregroundColor(.black)
                    .padding(.leading, 170)
                Text("0 Comments")
                    .foregroundColor(isHovered ?  Color(red: 0.9, green: 0.39, blue: 0.64)  : .black)
                    .underline()
                //using the gesture method from UIKit
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                isHovered = true
                            }
                            .onEnded { _ in
                                isHovered = false
                            }
                    )
            }
            //add the video
            WebView(url: URL(string: "https://www.youtube.com/embed/Qbq01KvOFz0")!)
                .frame(height: 250)
                .padding(.horizontal, 22)
                .padding(.leading, 150)
        }
    }
}

//lets me see the updates (just a preview of the code you are doing)
struct BlogView_Previews: PreviewProvider {
    static var previews: some View {
        BlogView()
    }
}
