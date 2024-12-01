//
//  HomeView.swift
//  Project
//
//  Created by Christian Hernandez on 10/3/24.
//
import SwiftUI


struct HomeView: View {
    @State private var userSearchText: String = ""
    //this will allow to change and the string is currently empty-> there is no value (nil)
    @State private var currentlyExpanded: String? = nil
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
                                        .foregroundColor(.gray)
                                        .padding(.leading, 10)
                                }
                                TextField("", text: $userSearchText)
                                    .padding(.leading, 10)
                                    .padding(.vertical, 10)
                                    .padding(.trailing, 35)
                                    .background(Color.pink.opacity(0.2))
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
                                    .foregroundColor(.black)
                            }
                            .padding(.top,8)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                        }
                        
                        //this has to have a small space and it is vertical display (top to bottom)
                        VStack(spacing: 2) {
                            CategorySectionView(title: "SEWING PATTERN TUTORIAL VIDEOS", textColor: .black, plusColor: .gray,currentlyExpanded: $currentlyExpanded)
                            CategorySectionView(title: "EMBROIDERY FILE VIDEOS", textColor: .black, plusColor: .gray,currentlyExpanded: $currentlyExpanded)
                            CategorySectionView(title: "TOOLS & SUPPLIES VIDEOS", textColor: .black, plusColor: .gray,currentlyExpanded: $currentlyExpanded)
                            CategorySectionView(title: "CUT & SEW FABRIC PANEL SEWALONG VIDEOS", textColor: .black, plusColor: .gray,currentlyExpanded: $currentlyExpanded)
                            CategorySectionView(title: "FAQS", textColor: .gray, plusColor: .gray,currentlyExpanded: $currentlyExpanded)
                        }
                    }
                    .padding(.bottom, 15)
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
                    
                    //call the struct here
                    KofiSocialMediaIcon()
                        .padding(.top , 10)
                        .padding(.bottom, 20)
                    
                    //call the struct here
                    SlideShowReviews()
                        .padding(.top, -10)
                        .padding(.bottom, 20)
                    
                    //call the promotion struct here and pass in the images
                    CustomersImagesUpload(images: [
                        "customerimage1","customerimage2","customerimage3","customerimage4",
                        "customerimage5","customerimage6","customerimage7","customerimage8"
                    ])
                    .padding(.bottom, 10)
                    //reuse the struct that you created that goes after all the information
                    InformationAfterImages()
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
    //this will control the switching between '+' and '-' buttons
    @State private var expanded: Bool = false
    //allows two way connection with the parent-> won't know if it has a value yet
    @Binding var currentlyExpanded: String?
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(textColor)
                    .padding(.leading)
                //using spacer to cover all the space side to side
                Spacer()
                Button(action: {
                    if (currentlyExpanded == title) {
                        currentlyExpanded = nil
                    }
                    //this will run first since the currentlyExpanded is nil
                    else {
                        //set it to the title
                        currentlyExpanded = title
                    }
                }) {
                    //this is a ternary if true then run minus false run plus
                    Image(systemName: expanded ? "minus" : "plus")
                        .foregroundColor(plusColor)
                        .padding(.trailing)
                }
            }
            .frame(height: 50)
            .background(Color.pink.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)
            
            //this runs since it will be equal and go in the switch to get the information
            if(currentlyExpanded == title) {
                switch (title) {
                case "SEWING PATTERN TUTORIAL VIDEOS":
                    SewingVideos()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                case "EMBROIDERY FILE VIDEOS":
                    EmbroideryVideos()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                case "TOOLS & SUPPLIES VIDEOS":
                    ToolVideos()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                case "CUT & SEW FABRIC PANEL SEWALONG VIDEOS":
                    CutAndSewVideos()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                case "FAQS":
                    Text("HI")
                default:
                    Text("Not Found ")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical , 5)
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
    var rating: Int
    var description: String
    var image: String
}
//precondition: call the Reviews struct
//postconiditon: this struct is going to be used to create a slideshow of the reviews customers have left
struct SlideShowReviews: View {
    // Array of customer reviews
    let reviewsInformation: [Reviews] = [
        Reviews(id: 1, name: "Kristin", rating: 5, description: "easy to down load. easy to use", image: "dogimage1"),
        Reviews(id: 2, name: "Mallory", rating: 5, description: "Easy to follow instructions for this newbie sewer. Loved that it included svg files as well!", image: "ghostimage2"),
        Reviews(id: 3, name: "Kyli", rating: 5, description: "First sewing pattern ever and such a great experience!! So easy to follow with wonderful directions🩷 my baby loved it! Our family Mario theme was complete!", image: "princeimage3"),
        Reviews(id: 4, name: "Barbara", rating: 5, description: "This pattern is very simple, and the finished project is great!", image: "dogimage4"),
        Reviews(id: 5, name: "Jamie", rating: 5, description: "So easy to put together! My daughter loves her King Boo costume", image: "princeimage3"),
        Reviews(id: 6, name: "Marisa", rating: 5, description: "So cute! Thank you! !", image: "appleimage5"),
        Reviews(id: 7, name: "Charmaine", rating: 5, description: "Great pattern easy to use - the video is super helpful!", image: "dogimage4"),
        Reviews(id: 8, name: "Annette", rating: 5, description: "A+ Services A+ A+ A+", image: "grinchimage6"),
        Reviews(id: 9, name: "Lisa", rating: 5, description: "This file was easy to open and easy to read. You get a lot for the price. The pattern worked out perfectly for my King Boo costume.", image: "princeimage3")
    ]
    //using index to track the current slide
    @State private var currentIndex = 0
    var body: some View {
        //need a vertical-> TabView goes first then the dots-> vertical is top to bottom
        VStack {
            //lets the user to swipe through the reviews
            TabView(selection: $currentIndex) {
                ForEach(reviewsInformation.indices, id: \.self) { index in
                    //has to be horizontal-> image then description, need a VStack inside Hstack
                    HStack {
                        //will start at index[0]... then increment as the tabview changes
                        Image(reviewsInformation[index].image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.top, 10)
                        //this will put the name,rating,description-> vertical (top to bottom)
                        VStack(alignment: .leading, spacing: 8) {
                            Text(reviewsInformation[index].name)
                                .font(.headline)
                                .foregroundColor(.black)
                            //side to side for the stars so using HStack
                            HStack(spacing: 2) {
                                //have to loop from 1-5 since there can only be those ratings
                                ForEach(1...5, id: \.self) { star in
                                    //terinay operator if true then go to the first one else just star
                                    Image(systemName: star <= reviewsInformation[index].rating ? "star.fill" : "star")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 14, height: 14)
                                        .foregroundColor(.pink)
                                }
                            }
                            Text(reviewsInformation[index].description)
                                .font(.body)
                                .foregroundColor(.gray)
                                .lineLimit(nil)
                        }
                        .padding()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.2),radius: 8, x: 0, y: 5)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.pink.opacity(0.5),lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .shadow(radius: 5)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 200)
            //dots have to be side to side-> must be horizontal
            HStack {
                //customizing the dots
                ForEach(reviewsInformation.indices, id: \.self) { index in
                    Button(action: {
                        //set the currentIndex to the tapped dot index
                        currentIndex = index
                    }) {
                        Circle()
                        //if the currentIndex is being used then it is pink else-> other buttons are gray
                            .fill(currentIndex == index ? Color.pink.opacity(0.2) : Color.gray)
                            .frame(width: 10, height: 10)
                            .padding(4)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.bottom, 5)
        }
        .padding(.top, 10)
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
        }
    }
}

//lets me see the updates (just a preview of the code you are doing)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
