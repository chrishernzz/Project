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
    @State private var playlistView = false
    
    var body: some View{
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    //only need two-> prefix will allow this
                    ForEach(videoArray.prefix(2), id: \.self) {item in
                        WebView(url: item)
                            .frame(height: 150)
                            .padding(.horizontal, 5)
                            .padding(.bottom, 50)
                    }
                }
                .padding(.leading, 5)
                .padding(.trailing, 5)
                .padding(.bottom, -50)
                
                //create a button if they click on view playlist
                Button(action: {
                    //flag it
                    playlistView = true
                }) {
                    Text("VIEW PLAYLIST>>")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(4)
                }
                .padding(.leading, 180)
            }
        }
        //this will now be true since user press the button it activates it, so it will create a full screen then show the playlist-> Sewing Playlist
        .fullScreenCover(isPresented: $playlistView) {
            EmbroideryFileVideosPlaylist(videoArray: videoArray)
        }
    }
}

//precondition: NONE
//postcondition: this struct will allow to view the whole playlist
struct EmbroideryFileVideosPlaylist: View {
    var videoArray: [URL]
    //this will create a dismiss button if user does not want to view the playlist
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            //have to have side to side which indicates a '<' back button and the playlist we are in
            HStack {
                Button(action: {
                    dismiss()
                }){
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding()
                }
                .padding(.leading, -90)
                Text("Embroidery File Playlist")
                    .foregroundColor(.black)
                    .font(.headline)
                    .padding()
            }
            .padding(.top, 20)
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
