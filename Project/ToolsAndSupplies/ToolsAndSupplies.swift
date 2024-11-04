//
//  ToolsAndSupplies.swift
//  Project
//
//  Created by Christian Hernandez on 11/1/24.
//
import SwiftUI

struct ToolsAndSupplies: View {
    @Binding var subSidebarOpen: Bool
    let toolsAndSuppliesItems: [ToolsAndSuppliesSidebarItem] = [
        ToolsAndSuppliesSidebarItem(name: "FOR SEWING"),
        ToolsAndSuppliesSidebarItem(name: "FOR EMBROIDERY"),
        ToolsAndSuppliesSidebarItem(name: "FOR CRAFTING"),
        ToolsAndSuppliesSidebarItem(name: "FOR OFFICE/SHIPPING"),
        ToolsAndSuppliesSidebarItem(name: "FOR ORGANIZATION"),
        ToolsAndSuppliesSidebarItem(name: "FOR PHOTOGRAPHY")
    ]
    
    var body: some View {
        ZStack{
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 10) {
                // Back button to return to main sidebar options
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
                
                // List of tools and supplies options
                ForEach(toolsAndSuppliesItems) { item in
                    Button(action: {
                        print("\(item.name) selected")
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
}
//precondition: NONE
//postcondition: this struct takes in name that carries the sub sidebar information
struct ToolsAndSuppliesSidebarItem: Identifiable {
    var id: String { name }
    var name: String
}


//preview
struct ToolsAndSupplies_Previews: PreviewProvider {
    @State static var subSidebarOpen = true
    static var previews: some View {
        ToolsAndSupplies(subSidebarOpen: $subSidebarOpen)
    }
}
