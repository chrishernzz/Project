//
//  EmbroideryPlaylistVideos.swift
//  Project
//
//  Created by Christian Hernandez on 12/2/24.
//

import SwiftUI

struct EmbroideryPlaylistVideos: View {
    //create an array of URLs-> this will be private and only access through here
    private var videoArray: [URL] = [
        URL(string: "https://www.youtube.com/embed/1pIonlHF_Eo")!,
        URL(string: "https://www.youtube.com/embed/WriDC_46K5M")!,
        URL(string: "https://www.youtube.com/embed/-Rx6KJLaadI")!,
        URL(string: "https://www.youtube.com/embed/SAlcp7pnOSM")!,
        URL(string: "https://www.youtube.com/embed/kJ3O_1UdWRc")!,
        URL(string: "https://www.youtube.com/embed/S8Bj6T7XCbs")!,
        URL(string: "https://www.youtube.com/embed/xE5RFjGHIDk")!,
        URL(string: "https://www.youtube.com/embed/6HGeL2i2BP0")!,
        URL(string: "https://www.youtube.com/embed/Ex2_3gfchUw")!,
        URL(string: "https://www.youtube.com/embed/JTYo2nk5LNY")!,
        URL(string: "https://www.youtube.com/embed/v8B7Js1r1Yk")!,
        URL(string: "https://www.youtube.com/embed/L0R60m7kV2I")!,
        URL(string: "https://www.youtube.com/embed/XSFLSUrnbmw")!,
        URL(string: "https://www.youtube.com/embed/KzTBPFUhzuM")!
    ]
    var body: some View {
        VStack {
            Text("Embroidery File Playlist")
                .foregroundColor(.black)
                .font(.headline)
                .padding()
                .padding(.top, 50)
            //only make the videos playlist scrolling options
            ScrollView {
                ForEach(videoArray, id: \.self) {video in
                    WebView(url: video)
                        .frame(height: 200)
                        .padding(.horizontal, 5)
                        .padding(.bottom, 30)
                }
            }
        }
        .background(Color.white)
    }
}

