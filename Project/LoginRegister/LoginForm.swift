//
//  LoginForm.swift
//  Project
//
//  Created by Isaiah Vogt on 11/27/24.
//

import Foundation
import SwiftUI

struct LoginForm: View {
    /* Used for state update/change */
    @State private var validLogIn = false
    @State private var username = ""
    @State private var password = ""
    @State private var isUserNameEmpty = false
    @State private var isPasswordEmpty = false
    
    var body: some View {
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            //allows user to scroll the view
            ScrollView {
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.2), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 200)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, -16)
                //information is vertical-> text, then the name, email, subject, and message but in they are horizontal so you create HStack inside, will have a leading space of 20 from the far left
                VStack(alignment: .leading, spacing: 20) {
                    Text("Get in Touch With Us")
                        .font(.system(size: 20))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, -100)
                    //if user does send the message then it is true
                    if (validLogIn){
                        Text("You are now logged in.")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .padding(.bottom)
                    }
                    else{
                        // form objects
                        LoginUserName(username: $username, isUserNameEmpty: $isUserNameEmpty).padding(.top, -50)
                        LoginPassword(password: $password, isPasswordEmpty: $isPasswordEmpty)
                        // submit form objects
                        Button(action: { validateUserLogin()
                        }){
                            Text("Log in")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        .padding(.top, 0)
                        .padding(.bottom, 20)
                        // empty input validation
                        if (isUserNameEmpty || isPasswordEmpty) {
                            Text("Please correct the highlighted fields")
                                .padding(.top, -30)
                                .foregroundColor(.black)
                                .font(.footnote)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top , 20)
                //going to reuse the function that goes after all the information
                InformationAfterImages()
            }
        }
    }
    
    // ensures are not empty
    private func validateUserLogin() {
        isUserNameEmpty = username.isEmpty
        isPasswordEmpty = password.isEmpty
        
        if(!isUserNameEmpty && !isPasswordEmpty) {
            
            /* hash the password from plaintext. This function is located in the sister file SignUpForm.swift */
            let hashedpassword = hashPassword(password)
            
            password = hashedpassword
            
            /* Prepare user and password as json string */
            let userPayload: [String: Any] = ["username": username, "password": password]
            
            do {
                // Serialize the dictionary to JSON data
//                let jsonData = try JSONSerialization.data(withJSONObject: userPayload, options: [])
            /* API call to log in user*/
            ClientServer.shared.testLoad(url: "/user/login", method: "POST", payload: userPayload) { result in
                
                switch result {
                case .success(let responseString):
                    print("Response: \(responseString)")
                    /* If returns with status 200 then validLogIn to true*/
                    validLogIn = true
                    clearValidFields()
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    }
                }
            } catch {
                print("Error serializing JSON: \(error.localizedDescription)")
            }
        }
    }
    private func clearValidFields() {
        username = ""
        password = ""
    }
}

struct LoginUserName: View {
    @Binding var username: String
    @Binding var isUserNameEmpty: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Username *")
                .foregroundColor(.black)
            //need the first and last name side to side->horizontal
            HStack {
                // CustomTextFColor is defined in the sister file SignUpForm.swift
                CustomTextFColor(nameHolder: "user", text: $username, emptyCheck: $isUserNameEmpty)
            }
        }
    }
}

struct LoginPassword: View {
    @Binding var password: String
    @Binding var isPasswordEmpty: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Password *")
                .font(.subheadline)
                .foregroundColor(.black)
            // CustomTextFColor is defined in the sister file SignUpForm.swift
            CustomTextFColor(nameHolder: "", text: $password, emptyCheck: $isPasswordEmpty)
            //the .onChange will be trigger everytime the specifed value changes
                .onChange(of: password) {
                }
            //this error will only display if the email is not valid and also if the email is not empty
            if ( !password.isEmpty) {
                Text("Please enter a valid password.")
                    .font(.footnote)
                    .foregroundColor(.black)
            }
        }
    }
}
