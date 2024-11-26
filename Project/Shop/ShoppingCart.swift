//
//  ShoppingCart.swift
//  Project
//
//  Created by Christian Hernandez on 11/20/24.
//

import Foundation
import SwiftUI

struct ShoppingCart: View {
    var body: some View {
        ZStack{
            
            //even if dark mode we want background to be white
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("0 items in your cart")
                        .foregroundColor(.black)
                    Text("close")
                        .foregroundColor(.gray)
                }
                Text("Keep Shopping!:)")
                    .foregroundColor(.gray)
            }
        }

    }
}
