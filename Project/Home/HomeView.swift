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
            Color.white.edgesIgnoringSafeArea(.all)
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
                        
                        //this has to have a small space and it is vertical display
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
                                .padding(.horizontal, 20)
                                .background(Color.black)
                                .cornerRadius(5)
                        }
                    }
                    //make the box taller
                    .padding(.vertical, 30)
                    //how thin you want it to be
                    .padding(.horizontal, -5)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 2)
                    
                    //call the function here
                    KofiSocialMediaIcon()
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

//this struct is for the information of KoFi Media
struct KofiSocialMediaIcon: View {
    var body: some View {
        //button -> once user clicks on it then it goes to the Ko-fi URL
        Button(action: {
            // Open the Ko-fi page when the button is clicked
            if let koFiUrl = URL(string: "https://ko-fi.com/yeseniadesigns") {
                UIApplication.shared.open(koFiUrl)
            }
        }) {
            //horizontal -> coffee logo first then the 'Support Me on Ko-fi'
            HStack {
                //layered top of another -> this is because we are first using a cup then we want the heart to be over the cup
                ZStack {
                    Image(systemName: "cup.and.saucer.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.pink)

                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.white)
                        .offset(y: -2)  // Slightly adjust heart position inside cup
                }
                Text("Support Me on Ko-fi")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.pink.opacity(0.2))
            .cornerRadius(10)
        }
    }
}

//lets me see the updates (just a preview of the code you are doing)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
