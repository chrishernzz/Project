//
//  NewsLetter.swift
//  Project
//
//  Created by Christian Hernandez on 11/5/24.
//

import SwiftUI

struct NewsLetter: View {
    @State private var submittedMessage = false
    @State private var firstNameInfo = ""
    @State private var emailAddressInfo = ""
    @State private var isFirstNameInfoEmpty = false
    @State private var isEmailAddressInfoEmpty = false
    
    var body: some View {
        ZStack{
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            //if user does send the message then it is true
            if (submittedMessage){
                Text("Thanks for subscribing!")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .padding(.bottom)
            }
            else{
                //call the struct here
                NewsLetterInformation(firstNameInfo: $firstNameInfo, emailAddressInfo: $emailAddressInfo, isFirstNameInfoEmpty: $isFirstNameInfoEmpty, isEmailAddressInfoEmpty: $isEmailAddressInfoEmpty, submitSubscribe: validateUserInputs)
            }
        }
    }
    //precondition: NONE
    //postcondition: going to check if the input is not empty, if that is true then submittedMessage is true->shows the message then we clear the screen
    private func validateUserInputs() {
        //flag the variables to empty
        isFirstNameInfoEmpty = firstNameInfo.isEmpty
        isEmailAddressInfoEmpty = emailAddressInfo.isEmpty
        
        //if all variables are not empty (fill in) run this and call the clearValidFields()
        if (!isFirstNameInfoEmpty && !isEmailAddressInfoEmpty) {
            //flag it to true so now it will show the message
            submittedMessage = true
            //clear the input after-> by doing this you set everything to empty strings(call the function)
            clearValidFields()
        }
    }
    //just clears the information once everything is valid
    private func clearValidFields() {
        firstNameInfo = ""
        emailAddressInfo = ""
    }
    
}
struct NewsLetterInformation: View {
    @Binding var firstNameInfo: String
    @Binding var emailAddressInfo: String
    @Binding var isFirstNameInfoEmpty: Bool
    @Binding var isEmailAddressInfoEmpty: Bool
    //going to create a closure function to passed in and we need this for the trigger validation
    var submitSubscribe: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                // Header frame with website link text
                Text("WWW.YESENIADESIGNS.COM")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .background(Color.pink.opacity(0.2))
                    .foregroundColor(.white)
                    .padding(.horizontal, -16)
                    .padding(.top, 43)
                Image("headshotimage1")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height:400)
                    .cornerRadius(12)
                    .padding(.horizontal, -10)
                    .padding(.top,-50)
                Text("Don't Miss a\nStitch!\nJoin the List")
                    .font(.system(size: 50))
                //.fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.black)
                    .padding(.top, -90)
                Text("Sign up to receive email updates on our blog and shop! Get exclusive coupon codes, deals and so much\nmore!")
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                //create a vertical-> this is for the input user information
                VStack(spacing: 5) {
                    ZStack(alignment: .leading) {
                        //if the name is empty then it will preview the text hold name with the color
                        if (firstNameInfo.isEmpty) {
                            Text("First Name")
                                .foregroundColor(.black)
                                .padding(.leading, 16)
                        }
                        TextField("", text: $firstNameInfo)
                            .padding()
                            .cornerRadius(5)
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(isFirstNameInfoEmpty ? Color.red : Color.black, lineWidth: 1))
                            .foregroundColor(.black)
                    }
                    ZStack(alignment: .leading) {
                        if (emailAddressInfo.isEmpty) {
                            Text("Email Address")
                                .foregroundColor(.black)
                                .padding(.leading, 16)
                        }
                        TextField("",text: $emailAddressInfo)
                            .padding()
                            .foregroundColor(.black)
                            .cornerRadius(5)
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(isEmailAddressInfoEmpty ? Color.red : Color.black, lineWidth: 1))
                            .foregroundColor(.black)
                    }
                    //create the button now
                    Button(action: {
                        //call the function here
                        submitSubscribe()
                    }) {
                        Text("Subscribe")
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.pink.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .cornerRadius(10)
                .shadow(radius: 1)
                //check if the any of the validation is empty if so then error-> if any are true that are empty then print the error
                if (isFirstNameInfoEmpty || isEmailAddressInfoEmpty ) {
                    //print an error
                    Text("Please correct the highlighted fields")
                        .padding(.top, -20)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                Text("We respect your privacy. Unsubscribe at any time.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.top, -5)
                    .padding(.bottom, 50)
                
                //lastly just place the information of her company
                Text("© 2012-2024 YESENIA DESIGNS. ALL RIGHTS RESERVED.")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10)
            }
            .padding()
        }
    }
}
//lets me see the updates (just a preview of the code you are doing)
struct NewsLetter_Previews: PreviewProvider {
    static var previews: some View {
        NewsLetter()
    }
}

