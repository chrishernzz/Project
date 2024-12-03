//
//  MainWatchVideos.swift
//  Project
//
//  Created by Christian Hernandez on 12/2/24.
//

import SwiftUI

struct MainWatchVideos: View{
    @Binding var isSubSidebarOpen: Bool
    @Binding var subSidebarOpen: Bool
    @Binding var selectTheOption: String
    
    //creating an array of names to loop from
    let watchVideos: [MainWatchVideosItems] = [
        MainWatchVideosItems(name: "SEWING PATTERN TUTORIAL VIDEOS"),
        MainWatchVideosItems(name: "EMBROIDERY FILE VIDEOS"),
        MainWatchVideosItems(name: "YOUTUBE"),
        MainWatchVideosItems(name: "REELS"),
        MainWatchVideosItems(name: "TIKTOK")
    ]
    var body: some View {
        ZStack{
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 5) {
                //will return to the main sub view
                Button(action: {
                    subSidebarOpen = false
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("BACK")
                    }
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top, 10)
                    
                }
                //now loop throught the options starting at index[0]...index[n]
                ForEach(watchVideos) { item in
                    Button(action: {
                        //set the paramter to the name the user picked
                        selectTheOption = item.name
                        //now flag the isSubSidebarOpen-> we don't want it open
                        isSubSidebarOpen = false
                        subSidebarOpen = false
                    }) {
                        Text(item.name)
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.top, 10)
                    }
                }
                Spacer()
            }
            .padding(.leading, 13)
            .padding(.trailing, -13)
            
        }
    }
}
//precondition: requires a unique identifier for each instance, which allows to distinguish one item from another-> using Identifiable.
//postcondition: this struct takes in name that carries the sub sidebar information
struct MainWatchVideosItems: Identifiable {
    var id: String { name }
    var name: String
}

