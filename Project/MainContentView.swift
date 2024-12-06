//
//  MainContentView.swift
//  Project
//
//  Created by Christian Hernandez on 10/3/24.
//
import SwiftUI

struct MainContentView: View {
    @State private var videoShowScreen = true
    //state variable to control the sidebar-> state lets it update/change and only within the this view
    @State private var isSidebarOpen = false
    @State private var subSidebarOpen1 = false
    @State private var subSidebarOpen2 = false
    @State private var subSidebarOpen3 = false
    
    //state variable to show the contact form
    @State private var showContactForm = false
    
    //will show the shopping cart if user clicks on that option
    @State private var shoppingCartAvailable = false
    
    //initialize it to Home Page right away
    @State private var currentView: String = "HOME"
    //initialize it to home meaning it will be shaded gray since the app takes you to the homepage right away-> this controls what color sidebar it is depending on user option
    @State private var selectedOption: String = "HOME"
    
    //set it into an array of the information (the sidebar view)
    let sidebarItems: [SidebarItem] = [
        SidebarItem(name: "HOME", viewName: "HOME"),
        SidebarItem(name: "BLOG", viewName: "BLOG"),
        SidebarItem(name: "WATCH VIDEOS", viewName: "WATCH VIDEOS"),
        SidebarItem(name: "SHOP", viewName: "SHOP"),
        SidebarItem(name: "ORDERS", viewName: "ORDERS"),
        SidebarItem(name: "TOOLS & SUPPLIES", viewName: "TOOLS & SUPPLIES"),
        SidebarItem(name: "NEWSLETTER", viewName: "NEWSLETTER"),
        SidebarItem(name: "CONTACT", viewName: "CONTACT"),
        SidebarItem(name: "LOG IN | REGISTER", viewName: "LOG IN | REGISTER"),
        SidebarItem(name: "LOG OUT", viewName: "LOG OUT")
    ]
    //this conforms to the view protocol-> describes what is displayed and the View means you need a body which means you confrom to view protocol
    var body: some View {
        ZStack {
            //even if dark mode we want background to be white
            Color.white
                .edgesIgnoringSafeArea(.all)
            //this is the intro-> when app opens it will give an animation
            if (videoShowScreen){
                VideoWelcoming{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            //flag it to false so then it can go to the homepage
                            videoShowScreen = false
                        }
                    }
                }
                .transition(.opacity)
            }
            else{
                //using switch to determine what view it is at
                switch (currentView) {
                case "HOME":
                    HomeView(blogOption: $currentView, selectedName: $selectedOption)
                case "BLOG":
                    BlogView()
                case "SEWING PATTERN TUTORIAL VIDEOS":
                    SewingPlaylistVideosLink()
                case "EMBROIDERY FILE VIDEOS":
                    EmbroideryPlaylistVideos()
                case "ETSY SHOP":
                    EtsyShopView()
                case "ORDERS":
                    OrderView()
                case "FAQS":
                    FAQSShop()
                case "SIZE CHART":
                    SizeChart(url: URL(string: "https://www.spoonflower.com/profiles/yeseniadesigns")!)
                case "FOR SEWING":
                    ForSewing()
                case "FOR EMBROIDERY":
                    ForEmbroidery()
                case "FOR CRAFTING":
                    ForCrafting()
                case "FOR OFFICE/SHIPPING":
                    ForOfficeAndShipping()
                case "FOR ORGANIZATION":
                    ForOrganization()
                case "FOR PHOTOGRAPHY":
                    ForPhotography()
                case "NEWSLETTER":
                    NewsLetter()
                case "CONTACT":
                    ContactInformation()
                case "LOG IN | REGISTER":
                    // Call login/register view here
                    AuthForm()
                case "LOG OUT":
                    // Show a placeholder or redirection
                    Text("Logging out...")
                        .onAppear {
                            handleLogout()
                            // Redirect to the login/register view after a slight delay
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                currentView = "LOG IN | REGISTER"
                            }
                        }
                default:
                    //if there are no views then error, this is the default
                    Text("View not found")
                        .font(.headline)
                        .foregroundColor(.gray)
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
                            //or you can call the currentView and pass it in the switch? idk?
                            //flag it to true so now they can see their cart
                            shoppingCartAvailable = true
                        }) {
                            Image(systemName: "cart")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding()
                        }
                        //this puts the view on top of the view we were just at-> to close you swipe down
                        .sheet(isPresented: $shoppingCartAvailable) {
                            ShoppingCart()
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
                            currentView = "ETSY SHOP"
                        })
                        SocialMediaIcon(imageName: "tiktokimage",url: "https://www.tiktok.com/@yeseniadesigns")
                        SocialMediaIcon(imageName: "mailimage", action: {
                            //flag it to true so now it is true -> you pass in the function that lets user fill in the information
                            showContactForm = true
                        })
                        Spacer()
                    }
                    //adjusting the horizontal padding so it can fit bar width
                    .padding(.horizontal, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
                //once the sidebar is clicked-> becomes true
                if (isSidebarOpen) {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            //this if,else if,and else will check if any sub side bars are open if not then it will go the other views
                            if (subSidebarOpen1) {
                                ToolsAndSupplies(isSubSidebarOpen: $isSidebarOpen,subSidebarOpen: $subSidebarOpen1,selectTheOption: $currentView)
                            }
                            else if (subSidebarOpen2) {
                                MainShop(isSubSidebarOpen: $isSidebarOpen, subSidebarOpen: $subSidebarOpen2, selectTheOption: $currentView)
                            }
                            else if (subSidebarOpen3) {
                                MainWatchVideos(isSubSidebarOpen: $isSidebarOpen, subSidebarOpen: $subSidebarOpen3, selectTheOption:  $currentView)
                            }
                            else{
                                //loop through the array (index[0]..etc)
                                ForEach(sidebarItems) { item in
                                    Button(action: {
                                        //now initilaize it to the view name
                                        selectedOption = item.viewName
                                        
                                        //have three options where it has to check if they are a sub sidebar
                                        if (item.viewName == "WATCH VIDEOS") {
                                            //flag it to true->this will now go back to the subSidebaropen and open it and in there the struct will be passed but won't close the first sidebar view still is open
                                            subSidebarOpen3 = true
                                        }
                                        //else the second subsidebar which is 'SHOP' will open up
                                        else if (item.viewName == "SHOP") {
                                            subSidebarOpen2 = true
                                        }
                                        //else the third subsidebar which is 'TOOLS & SUPPLIES' will open up
                                        else if (item.viewName == "TOOLS & SUPPLIES") {
                                            subSidebarOpen1 = true
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
                                                .foregroundColor(selectedOption == item.name ? .gray : .black)
                                                .padding(.top, 10)
                                                .padding(.leading,15)
                                            //since 'watch videos' and 'tools & supplies' is a sub sidebar-> has a '>' to tell it that there is an option
                                            if (item.name == "WATCH VIDEOS" || item.name == "TOOLS & SUPPLIES" || item.name == "SHOP") {
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(selectedOption == item.name ? .gray : .black)
                                                    .font(.headline)
                                                    .padding(.top, 10)
                                                    .padding(.trailing, 10)
                                            }
                                        }
                                    }
                                }
                            }
                            //going to take up all space as much as it can-> vertical here
                            Spacer()
                        }
                        .padding(.leading, -20)
                        .padding(.top, 15)
                        .frame(width: UIScreen.main.bounds.width * 0.6)
                        //RGB COLOR
                        .background(Color(red: 239/255, green: 237/255, blue: 242/255))
                        .offset(x: isSidebarOpen ? 0 : -UIScreen.main.bounds.width * 0.6) 
                        .animation(.easeInOut(duration: 0.3), value: isSidebarOpen)
                        //same thing here but now horizontal
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
            
            
        }
        .animation(.easeInOut(duration: 0.5), value: videoShowScreen)
    }
}
//precondition: requires a unique identifier for each instance, which allows to distinguish one item from another-> using Identifiable and needs an ID(key->value).
//postcondition: this struct takes in name and viewName that carries the sidebar information
struct SidebarItem: Identifiable {
    //passing two parameters
    var id: String { name }
    var name: String
    //this variable will hold the viewname->changes everytime user clicks on what view they want
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
        }
        .padding(5) // Adjust padding as needed
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.pink.opacity(0.2))
                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 3)
        )
        .cornerRadius(8)
    }
}
//precondition: NONE
//postcondition: this struct will allow the instagram and youtube icon with its url
struct InstagramAndYoutubeLink: View{
    //two parameters for the image and url
    var socialMediaImage: String
    var url: URL
    //can pass this-> won't be refer as a parameter
    @Environment(\.openURL) var openurl
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
// handle log out
func handleLogout() {
    if let token = UserDefaults.standard.string(forKey: "authToken") {
        print("Logging out user with token: \(token)")
        
        // Clear the token
        UserDefaults.standard.removeObject(forKey: "authToken")
        
        if UserDefaults.standard.string(forKey: "authToken") == nil {
            print("User logged out successfully. Token cleared.")
        } else {
            print("Failed to clear token.")
        }
    } else {
        print("No token found. User already logged out.")
    }
}


//shows the final preview of all the structs combined
struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}

