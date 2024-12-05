//
//  CutAndSewVideos.swift
//  Project
//
//  Created by Christian Hernandez on 11/30/24.
//

import SwiftUI

struct CutAndSewVideos: View {
    //create an array of URLs
    @State private var videoArray: [URL] = [
        URL(string: "https://www.youtube.com/embed/3eHxjXqi5m8")!
    ]
    var body: some View{
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    ForEach(videoArray, id: \.self) {item in
                        WebView(url: item)
                            .frame(height: 200)
                            .padding(.horizontal, 5)
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


