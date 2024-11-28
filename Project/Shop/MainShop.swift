//
//  MainShop.swift
//  Project
//
//  Created by Christian Hernandez on 11/25/24.
//

import SwiftUI

struct MainShop: View{
    @Binding var isSubSidebarOpen: Bool
    @Binding var subSidebarOpen: Bool
    @Binding var selectTheOption: String
    //this allows the variable to change and update but only within this view
    @State private var subSidebarOpen1 = false
    
    //creating an array of names to loop from
    let mainShopItems: [MainShopSidebarItems] = [
        MainShopSidebarItems(name: "ETSY SHOP"),
        MainShopSidebarItems(name: "CUT & SEW FABRIC PRINTS"),
        MainShopSidebarItems(name: "FREE FILES"),
        MainShopSidebarItems(name: "FAQS"),
    ]
    var body: some View {
        ZStack{
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 5) {
                //if it goes to the sub sub view then go here since it is true
                if(subSidebarOpen1){
                    SubSidebarSubMenu(isSubSidebarOpen: $isSubSidebarOpen, subSidebarOpen: $subSidebarOpen ,selectTheOption: $selectTheOption, subSidebarOpen1: $subSidebarOpen1)
                }
                else{
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
                    ForEach(mainShopItems) { item in
                        Button(action: {
                            if(item.name == "CUT & SEW FABRIC PRINTS"){
                                //flag it to true so the sub sub view can be shown
                                subSidebarOpen1 = true
                            }
                            else{
                                //set the paramter to the name the user picked
                                selectTheOption = item.name
                                //now flag the isSubSidebarOpen-> we don't want it open
                                isSubSidebarOpen = false
                                subSidebarOpen = false
                            }
                        }) {
                            Text(item.name)
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(.top, 10)
                            //since 'cut & sew fabric prints'is a sub sidebar-> has a '>' to tell it that there is an option
                            if (item.name == "CUT & SEW FABRIC PRINTS") {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .padding(.top, 10)
                                    .padding(.trailing, 40)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

//precondition: NONE
//postcondition: this creates another sub sub view with two options and it will have binding so it can control two way data connection
struct SubSidebarSubMenu: View {
    @Binding var isSubSidebarOpen: Bool
    @Binding var subSidebarOpen: Bool
    @Binding var selectTheOption: String
    //this has to be binding so it can update the parent but in the parent it is a state since we only want two way connection here and there
    @Binding var subSidebarOpen1: Bool
    @Environment(\.openURL) var openURL
    
    //create an array
    let mainShopSubItems: [MainShopSidebarItems] = [
        MainShopSidebarItems(name: "SHOP FABRIC PRINTS"),
        MainShopSidebarItems(name: "SIZE CHART")
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            //will return to the sub view, closing the sub sub view
            Button(action: {
                subSidebarOpen1 = false
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
            ForEach(mainShopSubItems) { item in
                Button(action: {
                    //since this just requires a link to be open, we do an if and check it-> open the link then close the side bars
                    if(item.name == "SHOP FABRIC PRINTS") {
                        //going to unwrapped the link
                        if let url = URL(string: "https://www.spoonflower.com/profiles/yeseniadesigns") {
                            //will open the url
                            openURL(url)
                            subSidebarOpen1 = false
                            subSidebarOpen = false
                            isSubSidebarOpen = false
                        }
                    }
                    else{
                        //set the paramter to the name the user picked
                        selectTheOption = item.name
                        subSidebarOpen1 = false
                        subSidebarOpen = false
                        isSubSidebarOpen = false
                    }
                }) {
                    Text(item.name)
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.top, 10)
                }
            }
            Spacer()
        }
    }
}

//precondition: requires a unique identifier for each instance, which allows to distinguish one item from another-> using Identifiable.
//postcondition: this struct takes in name that carries the sub sidebar information
struct MainShopSidebarItems: Identifiable {
    var id: String { name }
    var name: String
}
