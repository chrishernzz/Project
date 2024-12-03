//
//  FAQSShop.swift
//  Project
//
//  Created by Christian Hernandez on 11/25/24.
//

import SwiftUI
import WebKit

struct FAQSShop: View {
    var body: some View {
        ZStack{
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color(red: 1.0, green: 0.94, blue: 0.96), Color.white]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, -16)
                    Text("FAQS")
                        .font(.custom("Lora-Bold", size: 35))
                        //RGB color
                        .foregroundColor(Color(red: 0.9, green: 0.39, blue: 0.64))
                        .padding(.top, -100)
                    //this will display first since we are doing VStack-> topt to bottom
                    Image("shopfrontcover")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.bottom, -10)
                    //adds a straight line
                    Divider()
                        .frame(width: 350, height: 1)
                        .background(Color.gray)
                        .padding(.top, 25)
                    Text("How to Access & Download Digital \n\t\t\t\t  Files")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .padding(.top,25)
                    //call the struct that creates the youtube video
                    WebView(url: URL(string: "https://www.youtube.com/embed/pkDgBO9PA-U")!)
                        .frame(height: 250)
                        .padding(.horizontal, 22)
                        .padding(.bottom, 50)
                    
                    //reusing this struct that was created earlier
                    InformationAfterImages()
                }
            }
        }
    }
}
//precondition: NONE
//postcondition: this struct will create a WKWebView into SwiftUI, allowing the display of web content or a YouTube video in your app.
struct WebView: UIViewRepresentable {
    //creating a URL as a parameter
    let url: URL
    
    //function will be called once the WebView is created/initialized
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        //you passsed in the parameter here so it can create it
        let request = URLRequest(url: url)
        //this will be called to load the web content specified by the url
        uiView.load(request)
    }
}


//shows the final preview of all the structs combined
struct FAQSShop_Preview: PreviewProvider {
    static var previews: some View {
        FAQSShop()
    }
}
