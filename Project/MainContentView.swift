//
//  MainContentView.swift
//  Project
//
//  Created by Christian Hernandez on 10/3/24.
//
import SwiftUI

struct MainContentView: View {
    //state variable to control the sidebar-> State lets it update/change
    @State private var isSidebarOpen = false
    @State private var subSidebarOpen = false
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
        SidebarItem(name: "TOOLS & SUPPLIES", viewName: "TOOLS & SUPPLIES"),
        SidebarItem(name: "NEWSLETTER", viewName: "NEWSLETTER"),
        SidebarItem(name: "CONTACT", viewName: "CONTACT"),
        SidebarItem(name: "LOG IN | REGISTER", viewName: "LOG IN | REGISTER")
    ]
    //this conforms to the view protocol-> describes what is displayed and the View means you need a body which means you confrom to view protocol
    var body: some View {
        ZStack {
            //even if dark mode we want background to be white
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            //check which view it is at and then call the struct
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
            else if (currentView == "FOR SEWING") {
                //call the struct from the tools and supplies since we passed in a parameter that takes in the currentView
                ForSewing()
            }
            else if (currentView == "FOR EMBROIDERY") {
                ForEmbroidery()
            }
            else if(currentView == "FOR CRAFTING") {
                ForCrafting()
            }
            else if(currentView == "NEWSLETTER"){
                NewsLetter()
            }
            else if (currentView == "CONTACT") {
                ContactInformation()
            }
            else if (currentView == "LOG IN | REGISTER") {
                // Call login/register view here
            }
            
            //overlay with toolbar (Sidebar and Shopping Cart) so the sidebar, logo,shopping cart go first then the logos (social media) because VStack is top to bottom
            VStack {
                //horizontal to create the sidebar, logo, and shopping cart
                HStack {
                    Button(action: {
                        //activates the side bar ->true
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
                        // Shopping cart action goes here once user clicks on the cart
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
                HStack(spacing: 10) {
                    Spacer()
                    SocialMediaIcon(imageName: "instagramimage", url: "https://www.instagram.com/yeseniadesigns/")
                    SocialMediaIcon(imageName: "youtubeimage", url: "https://www.youtube.com/@yeseniadesigns")
                    //set the currentView a
                    SocialMediaIcon(imageName: "shoppingcartimage", action: {
                        currentView = "SHOP"
                    })
                    SocialMediaIcon(imageName: "tiktokimage",url: "https://www.tiktok.com/@yeseniadesigns")
                    SocialMediaIcon(imageName: "mailimage", action: {
                        //flag it to true so now it is true -> you pass in the function that lets user fill in the information
                        showContactForm = true
                    })
                    Spacer()
                }
                .padding(.horizontal, 10) // Adjust horizontal padding to fit bar width
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            //once the sidebar is clicked-> becomes true
            if (isSidebarOpen) {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        if (subSidebarOpen){
                            //call the struct tools and supplies here
                            ToolsAndSupplies(isSubSidebarOpen: $isSidebarOpen,subSidebarOpen: $subSidebarOpen,selectTheOption: $currentView)
                        }
                        else{
                            //loop through the array (index[0]..etc)
                            ForEach(sidebarItems) { item in
                                Button(action: {
                                    //if user clicks the tools and supplies then go in here since it is a sub sidebar
                                    if (item.viewName == "TOOLS & SUPPLIES"){
                                        //flag it to true->this will now go back to the subSidebaropen and open it and in there the struct will be passed but won't close the first sidebar view still is open
                                        subSidebarOpen = true
                                    }
                                    //else if not that then go here and then close the side bar since it is not a sub sidebar
                                    else{
                                        //tell the button what view it is at -> set viewName equal to current view
                                        currentView = item.viewName
                                        //flag it back to false so we can close it
                                        isSidebarOpen = false
                                    }
                                }) {
                                    //since some have sub sidebar view then we have to do side to side(hstack)->the name then the '>' if there is a sub sidebar view
                                    HStack{
                                        //text.name is the name we gave it from the array
                                        Text(item.name)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .padding(.top, 10)
                                            .padding(.leading,15)
                                        //since tools & supplies is a sub sidebar-> has a '>' to tell it that there is an option
                                        if (item.name == "TOOLS & SUPPLIES") {
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.black)
                                                .font(.headline)
                                                .padding(.top, 10)
                                                .padding(.trailing, 10)
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.6)
                    .background(Color.white)
                    .transition(.move(edge: .leading))
                    
                    Spacer()
                }
                .background(Color.black.opacity(0.1))
                .onTapGesture {
                    isSidebarOpen.toggle()
                }
            }
            //if the show contact is true run this
            if (showContactForm){
                //call the function that shows the contact information
                ContactInformationForm(showForm: $showContactForm)
                    .transition(.move(edge: .bottom))
            }
        }
        .animation(.easeInOut, value: isSidebarOpen)
    }
}
//precondition: requires a unique identifier for each instance, which allows to distinguish one item from another-> using Identifiable and needs an ID(key->value).
//postcondition: this struct takes in name and viewName that carries the sidebar information
struct SidebarItem: Identifiable {
    //passing two parameters
    var id: String { name }
    var name: String
    //this variable willh old the viewname->changes everytime user clicks on what view they want
    var viewName: String
}
//postcondition: NONE
//postcondition: this struct creates the same shape for the images icons and has the url
struct SocialMediaIcon: View {
    //two parameters which accepts image and the url image->url
    var imageName: String
    //optional action
    var url: String? =  nil
    //optional action for non url as well (closure functions)
    var action: (()->Void)? = nil
    //can pass this-> won't be refer as a parameter since its Environment
    @Environment(\.openURL) var openurl
    var body: some View {
        //will create the button once user clicks on it
        Button(action: {
            if let url = url, let validUrl = URL(string: url){
                openurl(validUrl)
            }
            //if not a url then it will be an action-> the 'Shop' or 'Contact'
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
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .clipped()
            //.background(Color.pink.opacity(0.2))
        }
        .padding(5) // Adjust padding as needed
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.pink.opacity(0.2))
                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3) // Shadow effect
        )
        .cornerRadius(8) // Apply corner radius to the entire view
    }
}
//precondition: NONE
//postcondition: this struct is for the contact information when user needs to contact owner
struct ContactInformationForm: View {
    //passing in one parameter which is binding-> this is the child and it allows two way data connection
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
                            //TextField -> allows input
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
                                .padding(.top, -50)
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
                                //flag it to true -> they send the message to the owner so now show the message
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
                    if (!showConfirmationMessage) {
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
//precondition: NONE
//postcondition: this struct will allow the instagram and youtube icon with its url
struct InstagramAndYoutubeLink: View{
    //two parameters for the image and url
    var socialMediaImage: String
    var url: URL
    //can pass this-> won't be refer as a parameter
    @Environment (\.openURL) var openurl
    var body: some View{
        Button(action: {
            openurl(url)
        }){
            Image(socialMediaImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .clipped()
        }
    }
}

//shows the final preview of all the structs combined
struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
