//
//  EmbroideryVideos.swift
//  Project
//
//  Created by Christian Hernandez on 11/30/24.
//

import SwiftUI

struct EmbroideryVideos: View {
    //create an array of URLs
    @State private var videoArray: [URL] = [
        URL(string: "https://www.youtube.com/embed/1pIonlHF_Eo")!,
        URL(string: "https://www.youtube.com/embed/WriDC_46K5M")!
    ]
    var body: some View{
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    ForEach(videoArray, id: \.self) {item in
                        WebView(url: item)
                            .frame(height: 150)
                        //.padding(.horizontal, 22)
                            .padding(.bottom, 50)
                    }
                }
                .padding(.leading, 5)
                .padding(.trailing, 5)
                .padding(.bottom, -50)
                
                //create a button if they click on view playlist
                Button(action: {
                    //if they click view then in here we will call all the playlist
                }) {
                    Text("VIEW PLAYLIST>>")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(4)
                }
                .padding(.leading, 190)
            }
        }
    }
}

