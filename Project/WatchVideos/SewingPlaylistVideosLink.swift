//
//  SewingPlaylistVideosLink.swift
//  Project
//
//  Created by Christian Hernandez on 12/2/24.
//

import SwiftUI

struct SewingPlaylistVideosLink: View {
    //create an array of URLs-> this will be private and only access through here
    private var videoArray: [URL] = [
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
    var body: some View {
        VStack {
            Text("Sewing Pattern Tutorial Playlist")
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

//lets me see the updates (just a preview of the code you are doing)
struct SewingPlaylistVideosLink_Previews: PreviewProvider {
    static var previews: some View {
        SewingPlaylistVideosLink()
    }
}
