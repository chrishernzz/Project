//
//  MainContentView.swift
//  Project
//
//  Created by Christian Hernandez on 10/3/24.
//
import SwiftUI

//creating a struct that takes in name and viewName
struct SidebarItem: Identifiable {
    var id: String { name }
    var name: String
    var viewName: String  // The view it corresponds to
}

struct MainContentView: View {
    // State variable to control the sidebar
    @State private var isSidebarOpen = false
    // Initialize it to Home Page right away
    @State private var currentView: String = "HOME"

    //set it into an array of the information
    let sidebarItems: [SidebarItem] = [
        SidebarItem(name: "HOME", viewName: "HOME"),
        SidebarItem(name: "BLOG", viewName: "BLOG"),
        SidebarItem(name: "WATCH VIDEOS", viewName: "WATCH VIDEOS"),
        SidebarItem(name: "SHOP", viewName: "SHOP"),
        SidebarItem(name: "PORTFOLIO", viewName: "PORTFOLIO"),
        SidebarItem(name: "TOOLS & SUPPLIES", viewName: "TOOLS & SUPPLIES"),
        SidebarItem(name: "CONTACT", viewName: "CONTACT"),
        SidebarItem(name: "LOG IN | REGISTER", viewName: "LOG IN | REGISTER")
    ]

    var body: some View {
        ZStack {
            //even if dark mode we want background to be white
            Color.white
                .edgesIgnoringSafeArea(.all)

            //check which view it is at and then call those functions
            if (currentView == "HOME") {
                HomeView()
            }
            else if (currentView == "BLOG") {
                // Call the blog view here
            }
            else if (currentView == "WATCH VIDEOS") {
                // Call the watch videos view here
            }
            else if (currentView == "SHOP") {
                EtsyShopView()
            }
            else if (currentView == "PORTFOLIO") {
                // Call portfolio view here
            }
            else if (currentView == "TOOLS & SUPPLIES") {
                // Call tools and supplies view here
            }
            else if (currentView == "CONTACT") {
                // Call contact view here
            }
            else if (currentView == "LOG IN | REGISTER") {
                // Call login/register view here
            }

            //overlay with toolbar (Sidebar and Shopping Cart) so the sidebar, logo,shopping cart go first then the logos (social media) because VStack is top to bottom
            VStack {
                //horizontal to create the sidebar, logo, and shopping cart
                HStack {
                    Button(action: {
                        //activates the side bar
                        isSidebarOpen.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                    }
                    Spacer()
                    //get the logo from the assets
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Spacer()
                    Button(action: {
                        // Shopping cart action goes here
                    }) {
                        Image(systemName: "cart")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                    }
                }
                .padding(.horizontal)
                .background(Color.white)
                .frame(maxHeight: 50, alignment: .top)

                Spacer()
                //call the function to print out the logos (social media information) and it is horizontal
                HStack {
                    Spacer()
                    SocialMediaIcon(imageName: "instagramimage")
                    SocialMediaIcon(imageName: "youtube")
                    SocialMediaIcon(imageName: "cart")
                    SocialMediaIcon(imageName: "tiktok")
                    SocialMediaIcon(imageName: "envelope")
                    Spacer()
                }
                .padding(.bottom, 10)
            }

            //once the sidebar is clicked then it belongs true
            if (isSidebarOpen) {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        //loop throught the array (index[0]..etc)
                        ForEach(sidebarItems) { item in
                            Button(action: {
                                //tell the button what view it is at
                                currentView = item.viewName
                                //flag it back to false so we can close it
                                isSidebarOpen = false
                            }) {
                                //text.name is the name we gave it from the array
                                Text(item.name)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.top, 10)
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.6)  // Sidebar width is 60% of screen
                    
                    .background(Color.white)
                    .transition(.move(edge: .leading))

                    Spacer()
                }
                .background(Color.black.opacity(0.1))  // Semi-transparent overlay
                .onTapGesture {
                    isSidebarOpen.toggle()
                }
            }
        }
        .animation(.easeInOut, value: isSidebarOpen)
    }
}

//struct that creates the same shape for the images icons
struct SocialMediaIcon: View {
    var imageName: String
    var body: some View {
        //pass in the image from your assets
        Image(imageName)
            .resizable()
            .frame(width: 38, height: 22)
            .padding(10)
            .background(Color.pink.opacity(0.2))
            .cornerRadius(5)
    }
}


struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
