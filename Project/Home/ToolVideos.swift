//
//  ToolVideos.swift
//  Project
//
//  Created by Christian Hernandez on 11/30/24.
//

import SwiftUI


struct ToolVideos: View {
    //create an array of URLs
    @State private var videoArray: [URL] = [
        URL(string: "https://www.youtube.com/embed/iKcEmET71uc")!,
        URL(string: "https://www.youtube.com/embed/gCJLd4hnP2E")!,
        URL(string: "https://www.youtube.com/embed/7cNa__ETLdk")!,
        URL(string: "https://www.youtube.com/embed/9nxQdxlld5g")!,
        URL(string: "https://www.youtube.com/embed/SWcOjOrtKSs")!,
        URL(string: "https://www.youtube.com/embed/4y2uw1Z9aP8")!,
        URL(string: "https://www.youtube.com/embed/1Dfi3T84lCs")!,
        URL(string: "https://www.youtube.com/embed/NUWNU05lARI")!,
        URL(string: "https://www.youtube.com/embed/YnAFzPC5slI")!,
        URL(string: "https://www.youtube.com/embed/M3rYmSpCu1A")!,
        URL(string: "https://www.youtube.com/embed/BOgaTI_Ysso")!,
        URL(string: "https://www.youtube.com/embed/nNbcgFxYAxc")!,
        URL(string: "https://www.youtube.com/embed/ZgNqQPbnZ8c")!,
        URL(string: "https://www.youtube.com/embed/8j0T-aMPM4U")!,
        URL(string: "https://www.youtube.com/embed/aTOY-v5YDFM")!,
        URL(string: "https://www.youtube.com/embed/rDh1ZjvVS4s")!
    ]
    @State private var playlistView = false
    
    var body: some View{
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    //only want two for preview
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
            ToolsAndSuppliesVideos(videoArray: videoArray)
        }
    }
}


//precondition: NONE
//postcondition: this struct will allow to view the whole playlist
struct ToolsAndSuppliesVideos: View {
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
                Text("Tools & Supplies Playlist")
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

