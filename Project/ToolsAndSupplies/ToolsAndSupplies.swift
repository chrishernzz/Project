//
//  ToolsAndSupplies.swift
//  Project
//
//  Created by Christian Hernandez on 11/1/24.
//


import SwiftUI

struct ToolsAndSupplies: View {
    @State private var selectedCategory: String? = nil

    var body: some View {
        VStack(alignment: .leading) {
            if let category = selectedCategory {
                // Detailed view for a specific category
                HStack {
                    Button(action: {
                        // Go back to the main list
                        selectedCategory = nil
                    }) {
                        HStack {
                            Image(systemName: "chevron.left") // Back arrow icon
                            Text("BACK")
                        }
                        .foregroundColor(.black)
                        .padding()
                    }
                    Spacer()
                }
                
                // Display selected category information
                Text("You selected: \(category)")
                    .font(.title2)
                    .padding()
                
                // Add any additional content related to the selected category here
                
            } else {
                // Main Tools & Supplies list
                Text("TOOLS & SUPPLIES")
                    .font(.title)
                    .padding(.bottom, 10)
                
                // List of categories
                ForEach(["FOR SEWING", "FOR EMBROIDERY", "FOR CRAFTING", "FOR OFFICE/SHIPPING", "FOR ORGANIZATION", "FOR PHOTOGRAPHY"], id: \.self) { category in
                    Button(action: {
                        // Set the selected category to display its details
                        selectedCategory = category
                    }) {
                        Text(category)
                            .font(.headline)
                            .padding(.vertical, 8)
                    }
                    .foregroundColor(.black)
                }
            }
        }
        .padding()
    }
}



struct ToolsAndSupplies_Previews: PreviewProvider {
    static var previews: some View {
        ToolsAndSupplies()
    }
}

