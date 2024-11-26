//
//  ShopFabricPrints.swift
//  Project
//
//  Created by Christian Hernandez on 11/26/24.
//

import SwiftUI

struct ShopFabricPrints: View {
    var body: some View {
        ZStack{
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            VStack{
                Text("HI")
                    .foregroundColor(.black)
            }
        }
    }
}
