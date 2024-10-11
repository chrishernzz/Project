//
//  HomeView.swift
//  Project
//
//  Created by Christian Hernandez on 10/3/24.
//
import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""

    var body: some View {
        //top of another layered so the background is white then on top we have our view
        ZStack {
            //even if dark mode we want background to be white
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 20) {
                //this allows user to scroll up and down
                ScrollView {
                    VStack(spacing: 15) {
                        HStack {
                            ZStack(alignment: .leading) {
                                if (searchText.isEmpty) {
                                    Text("Search")
                                        .foregroundColor(.gray) // Customize the placeholder color for dark mode
                                        .padding(.horizontal, 20)
                                }
                                TextField("", text: $searchText)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color.pink.opacity(0.2))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .padding(.horizontal)
                                    .overlay(
                                        //print the search bar image
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.gray)  // Gray search icon
                                            .padding(.trailing, 30),
                                        alignment: .trailing
                                    )
                                    .foregroundColor(.gray)  // Ensure the text color is visible in dark mode
                                    .accentColor(.gray)       // Color of the blinking cursor
                            }
                        }
                        
                        // This has to have a small space and it is vertical display
                        VStack(spacing: 2) {
                            CategorySectionView(title: "SEWING PATTERN TUTORIAL VIDEOS", textColor: .black, plusColor: .gray)
                            CategorySectionView(title: "EMBROIDERY FILE VIDEOS", textColor: .black, plusColor: .gray)
                            CategorySectionView(title: "TOOLS & SUPPLIES VIDEOS", textColor: .black, plusColor: .gray)
                            CategorySectionView(title: "CUT & SEW FABRIC PANEL SEWALONG VIDEOS", textColor: .black, plusColor: .gray)
                            CategorySectionView(title: "LATEST VIDEO", textColor: .gray, plusColor: .gray)
                        }
                    }
                    //employee description about her
                    VStack(spacing: 15) {
                        Image("yeseniaheadshot")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 120, height: 120)
                        Text("YESENIA")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("DESIGNER, MAKER\nSharing my sewing, crafting & embroidery adventures!")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                        
                        Button(action: {
                            // Blog button action here
                        }) {
                            Text("BLOG")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20) // Reduce horizontal padding to make it thinner
                                .background(Color.black)
                                .cornerRadius(5)
                        }
                    }
                    //make the box taller
                    .padding(.vertical, 50)
                    //how thin you want it to be
                    .padding(.horizontal, -5)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 2)
                }
                .padding(.top, 70)
            }
        }
    }
}

//this creates the same size for the category section view (reused)
struct CategorySectionView: View {
    var title: String
    var textColor: Color
    var plusColor: Color
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(textColor)
                    .padding(.leading)
                Spacer()
                Image(systemName: "plus")
                    .foregroundColor(plusColor)
                    .padding(.trailing)
            }
            .frame(height: 50)
            .background(Color.pink.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)

        }
    }
}

//lets me see the updates (just a preview of the code you are doing)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
