//
//  MainContentView.swift
//  Project
//
//  Created by Christian Hernandez on 10/3/24.
//
import SwiftUI

//creating a struct that takes in name and viewName that carries the sidebar information
struct SidebarItem: Identifiable {
    var id: String { name }
    var name: String
    var viewName: String  // The view it corresponds to
}

struct MainContentView: View {
    //state variable to control the sidebar
    @State private var isSidebarOpen = false
    //state variable to show the contact form
    @State private var showContactForm = false
    //initialize it to Home Page right away
    @State private var currentView: String = "HOME"

    //set it into an array of the information (the sidebar view)
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
                    SocialMediaIcon(imageName: "instagramimage", url: "https://www.instagram.com/yeseniadesigns/")
                    SocialMediaIcon(imageName: "youtube", url: "https://www.youtube.com/@yeseniadesigns")
                        //set the currentView a
                    SocialMediaIcon(imageName: "cart", action: {
                        currentView = "SHOP"
                    })
                    SocialMediaIcon(imageName: "tiktok",url: "https://www.tiktok.com/@yeseniadesigns")
                    SocialMediaIcon(imageName: "envelope", action: {
                        //flag it to true
                        showContactForm = true
                    })
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
            //if the show contact is true run this
            if (showContactForm){
                //call the function
                ContactInformation(showForm: $showContactForm)
                    .transition(.move(edge: .bottom))
            }
        }
        .animation(.easeInOut, value: isSidebarOpen)
    }
}

//struct that creates the same shape for the images icons
struct SocialMediaIcon: View {
    var imageName: String
    //optional action
    var url: String? =  nil
    //optional action for non url as well (closure functions)
    var action: (()->Void)? = nil
    //lets me open url links
    @Environment(\.openURL) var openURL
    var body: some View {
        //will create the button once user clicks on it
        Button(action: {
            if let url = url, let validUrl = URL(string: url){
                openURL(validUrl)
            }
            else if let action = action{
                action()
            }
            //debugging purposes to test if url works or the actions
            else {
                print("Invalid URL or cannot open URL")
            }
        }){
            //pass in the image from your assets
            Image(imageName)
                .resizable()
                .frame(width: 35, height: 25)
                .padding(10)
                .background(Color.pink.opacity(0.2))
                .cornerRadius(5)
        }
    }
}
//this is for the contact information when user needs to contact owner
struct ContactInformation: View {
    @Binding var showForm: Bool
    //private variables for only contact information
    @State private var name = ""
    @State private var email = ""
    @State private var subject = ""
    @State private var message = ""
    @State private var showConfirmationMessage = false

    var body: some View {
        //need a layered on top of another because it has to be transparent
        ZStack {
            //semi-transparent background that covers the entire screen
            Color.black.opacity(0.6).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                ZStack(alignment: .topTrailing) {
                    //if they send message ->true then run this
                    if (showConfirmationMessage) {
                        //vertical so we can print the message out
                        VStack {
                            Text("Thank you for contacting us.")
                                .font(.headline)
                                .padding(.top, 20)
                                .foregroundColor(.black)
                                .colorScheme(.light)
                            Text("Your message has been submitted and we will be in touch with you as soon as possible.")
                                .multilineTextAlignment(.center)
                                .padding(.vertical, 10)
                                .foregroundColor(.black)
                                .colorScheme(.light)
                            Button(action: {
                                //flag it back to false -> closed the form
                                showForm = false
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.gray)
                                    .font(.title)
                                    .padding([.top, .trailing], 20)
                            }
                        }
                        .padding(30)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal, 20)
                    }
                    else {
                        //each box will have a 5 space gap in between
                        VStack(spacing: 5) {
                            TextField("Your name", text: $name)
                                .padding()
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .cornerRadius(5)
                                .foregroundColor(.black)
                                .colorScheme(.light)
                            TextField("Your email address", text: $email)
                                .padding()
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .cornerRadius(5)
                                .foregroundColor(.black)
                                .colorScheme(.light)
                            TextField("Subject", text: $subject)
                                .padding()
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .cornerRadius(5)
                                .foregroundColor(.black)
                                .colorScheme(.light)
                            TextField("Message...", text: $message)
                                .frame(height: 100)
                                .padding()
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .cornerRadius(5)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .colorScheme(.light)
                            Button(action: {
                                //flag it to true -> they send the message to the owner
                                showConfirmationMessage = true
                            }) {
                                Text("Send")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(Color.pink.opacity(0.2))
                                    .cornerRadius(5)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 50)
                    }
                    //close button (only for form)
                    if !showConfirmationMessage {
                        Button(action: {
                            showForm = false
                        }) {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.gray)
                                .font(.title)
                                .padding([.top, .trailing], 20)
                        }
                    }
                }

                Spacer()
            }
        }
    }
}


struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
