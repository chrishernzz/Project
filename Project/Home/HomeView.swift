//
//  HomeView.swift
//  Project
//
//  Created by Christian Hernandez on 10/3/24.
//
import SwiftUI

struct HomeView: View {
    @State private var userSearchText: String = ""
    var body: some View {
        //top of another layered so the background is white then on top we have our view
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 20) {
                //this allows user to scroll up and down
                ScrollView {
                    VStack(spacing: 15) {
                        //horizontal -> search goes first then the image of serach button (side to side)
                        HStack {
                            ZStack(alignment: .leading) {
                                if (userSearchText.isEmpty) {
                                    Text("Search")
                                        .foregroundColor(.gray) // Customize the placeholder color for dark mode
                                        .padding(.leading, 10)
                                }
                                TextField("", text: $userSearchText)
                                    .padding(.leading, 10)
                                    .padding(.vertical, 10)
                                    .padding(.trailing, 35)
                                    .background(Color.pink.opacity(0.2))
                                    //.frame(maxWidth: 300)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .overlay(
                                        //print the search bar image
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.gray)  // Gray search icon
                                            .padding(.trailing, 10),
                                        alignment: .trailing
                                    )
                                    .foregroundColor(.gray)  // Ensure the text color is visible in dark mode
                                    .accentColor(.gray)
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                        }
                        
                        //this has to have a small space and it is vertical display (top to bottom)
                        VStack(spacing: 2) {
                            CategorySectionView(title: "SEWING PATTERN TUTORIAL VIDEOS", textColor: .black, plusColor: .gray)
                            CategorySectionView(title: "EMBROIDERY FILE VIDEOS", textColor: .black, plusColor: .gray)
                            CategorySectionView(title: "TOOLS & SUPPLIES VIDEOS", textColor: .black, plusColor: .gray)
                            CategorySectionView(title: "CUT & SEW FABRIC PANEL SEWALONG VIDEOS", textColor: .black, plusColor: .gray)
                            CategorySectionView(title: "FAQS", textColor: .gray, plusColor: .gray)
                        }
                    }
                    //employee description about herself-> vertical which is headshot, name, about herself, and button-> takes you to blog
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
                        .padding(.top , 10)
                        .padding(.bottom, 20)
                    
                    //missing the slide view function here
                    
                    //call the promotion function here and pass in the images
                    CustomersImagesUpload(images: [
                        "customerimage1","customerimage2","customerimage3","customerimage4",
                        "customerimage5","customerimage6","customerimage7","customerimage8"
                    ])
                    
                    //add the instagram link and youtube link-> has to be side to side so use HStack-> horizontal
                    HStack{
                        //call the struct-> pass in the two parameters which are image and url
                        InstagramAndYoutubeLink(socialMediaImage: "instagramimage", url: "https://www.instagram.com/yeseniadesigns/")
                            .padding(.top, 100)
                            .padding(.bottom, 20)
                        InstagramAndYoutubeLink(socialMediaImage: "youtubeimage", url: "https://www.youtube.com/@yeseniadesigns")
                            .padding(.top, 100)
                            .padding(.bottom, 20)
                    }
                    //lastly just place the information of her company
                    Text("© 2012-2024 YESENIA DESIGNS. ALL RIGHTS RESERVED.")
                        .font(.caption)
                        //.regular doesn't make it as bold
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                        //have to center the text
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                }
                .padding(.top, 70)
            }
        }
    }
}
//precondition: NONE
//postcondition: this struct creates the same size for the category section view (reused)
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
//precondition: NONE
//postcondition: this struct is for the information of KoFi Media
struct KofiSocialMediaIcon: View {
    var body: some View {
        //button -> once user clicks on it then it goes to the Ko-fi URL so it has action
        Button(action: {
            //open the Ko-fi page when the button is clicked
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
                        .offset(y: -2)
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

//precondition: NONE
//postcondition: this struct will carry the information for the reviews and what product it is
struct Reviews: Identifiable {
    //the id-> makes sure each user had its own id, name,rating,descriptin,image->id
    var id: Int
    var name: String
    var rating: String
    var description: Double
    var image: String
}
//precondition: call the Reviews struct
//postconiditon: this struct is going to be used to create a slideshow of the reviews customers have left
struct SlideShowReviews: View {
    var body: some View {
        //need to use tabview-> lets user swipe side to side
        TabView {
            
        }
    }
}

//precondition: NONE
//postcondition: this struct will let me preview the images of customers that bought the costumes (reused)
struct CustomersImagesUpload: View {
    //create an array of images
    let images: [String]
    //creats an array that controls the columns and each
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        //we have to upload the images, two horizontal then vertical
        //vertical -> we want the promote the media first then the images
        VStack(spacing: 20) {
            //adds a straight line
            Divider()
                .frame(width: 300, height: 1)
                .background(Color.gray)
                .padding(.top, 20)
            Text("TAG US @YESENIADESIGNS")
                .font(.headline)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundStyle(Color.pink)
                .padding(.top, 10)
            //create image grid using LazyVGrid which means it is vertical grid
            LazyVGrid(columns: columns, spacing: 8){
                //have to use id: \.self to indicates that each user has an Id ex: image1 -> id 1...etc
                ForEach(images, id: \.self){imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal)
            
            //another divider for the second line
            Divider()
                .frame(height: 6)
                .background(Color.gray.opacity(0.3))
                .padding(.top, 5)
        }
    }
}
//precondition: NONE
//postcondition: this struct will allow the instagram and youtube icon with its url
struct InstagramAndYoutubeLink: View{
    //two parameters for the image and url
    var socialMediaImage: String
    var url: String
    //can pass this-> won't be refer as a parameter
    @Environment (\.openURL) var openurl
    var body: some View{
        Button(action: {
            if let urlValid = URL(string: url){
                openurl(urlValid)
            }
            //debug purposes
            else{
                print("Invalid URL")
            }
        }){
            Image(socialMediaImage)
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: 40, height: 40)
                .clipped()
        }
        .padding(.horizontal, -5)
        .cornerRadius(10)
    }
}

//lets me see the updates (just a preview of the code you are doing)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
