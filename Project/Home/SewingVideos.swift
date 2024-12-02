//
//  SewingVideos.swift
//  Project
//
//  Created by Christian Hernandez on 11/30/24.
//

import SwiftUI

struct SewingVideos: View {
    //create an array of URLs
    @State private var videoArray: [URL] = [
        URL(string: "https://www.youtube.com/embed/bnGyU8joCpo")!,
        URL(string: "https://www.youtube.com/embed/JPcT-OSWpYA")!,
        URL(string: "https://www.youtube.com/embed/YWpukWGkmts")!,
        URL(string: "https://www.youtube.com/embed/8oqIT5dUpLE")!,
        URL(string: "https://www.youtube.com/embed/n_Gg8gRA2Gg")!,
        URL(string: "https://www.youtube.com/embed/wjEJpbT47gQ")!,
        URL(string: "https://www.youtube.com/embed/coBmXjSi9oY")!,
        URL(string: "https://www.youtube.com/embed/5JX9wKG_NAE")!,
        URL(string: "https://www.youtube.com/embed/ef5M4PG_DvE")!,
        URL(string: "https://www.youtube.com/embed/PsgfXZ3JqKU")!,
        URL(string: "https://www.youtube.com/embed/iGvQvsYyLwI")!,
        URL(string: "https://www.youtube.com/embed/kCRCtMcOrOw")!,
        URL(string: "https://www.youtube.com/embed/4Zy9ml2rNx8")!,
        URL(string: "https://www.youtube.com/embed/2DievH2he6s")!,
        URL(string: "https://www.youtube.com/embed/Y7cFvlaY1Uc")!,
        URL(string: "https://www.youtube.com/embed/CXvpeFZqwdE")!,
        URL(string: "https://www.youtube.com/embed/zTtneV_QiBo")!,
        URL(string: "https://www.youtube.com/embed/788OcGk3Cwg")!,
        URL(string: "https://www.youtube.com/embed/SDmT86CEWPo")!,
        URL(string: "https://www.youtube.com/embed/wVfxMeNLtT4")!,
        URL(string: "https://www.youtube.com/embed/hJFCwnpKz9o")!,
        URL(string: "https://www.youtube.com/embed/S2J2sWnIwPc")!,
        URL(string: "https://www.youtube.com/embed/Fs_4w_TxwYg")!,
        URL(string: "https://www.youtube.com/embed/jEBqsufJyhE")!,
        URL(string: "https://www.youtube.com/embed/6v-A5kPChU0")!,
        URL(string: "https://www.youtube.com/embed/JUuGn3uQwX4")!,
        URL(string: "https://www.youtube.com/embed/KDaIiE3GPL0")!,
        URL(string: "https://www.youtube.com/embed/J6nlPRa-UxU")!,
        URL(string: "https://www.youtube.com/embed/zZTXgmmh_UU")!
    ]
    @State private var playlistView = false
    var body: some View{
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    //loop through only two of the videos since this is the preview-> prefix will allow the max lenth you want to loop through
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
                    //flag it to true meaning they want to see the playlist
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
        //this will now be true so it will create a full screen then show the playlist-> Sewing Playlist
        .fullScreenCover(isPresented: $playlistView) {
            SewingPlaylistVideos(videoArray: videoArray)
        }
    }
}

//precondition: NONE
//postcondition: this struct will allow to view the whole playlist
struct SewingPlaylistVideos: View {
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
                .padding(.leading, -60)
                Text("Sewing Pattern Tutorial Playlist")
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

//lets me see the updates (just a preview of the code you are doing)
struct SewingVideos_Previews: PreviewProvider {
    static var previews: some View {
        SewingVideos()
    }
}
