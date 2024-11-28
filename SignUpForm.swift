//
//  SignUpForm.swift
//  Project
//
//  Created by Isaiah Vogt on 11/27/24.
//

import Foundation
import SwiftUI
import CommonCrypto


struct UserSignUpForm: View {
    /* Used for state update/change */
    @State private var submittedSignUp = false
    @State private var username = ""
    @State private var password = ""
    @State private var isUserNameEmpty = false
    @State private var isPasswordEmpty = false
    @State private var isPasswordLengthValid = false
    
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
                    if (submittedSignUp){
                        Text("Thank you. Your account has been created.")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .padding(.bottom)
                    }
                    else{
                        // form objects
                        CustomerUserName(username: $username, isUserNameEmpty: $isUserNameEmpty).padding(.top, -50)
                        CustomerPassword(password: $password, isPasswordEmpty: $isPasswordEmpty)
                        // submit form objects
                        Button(action: { validateUserSignUp()
                        }){
                            Text("Sign Up")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        .padding(.top, 0)
                        .padding(.bottom, 20)
                        // empty input validation
                        if (isUserNameEmpty || isPasswordEmpty || isPasswordLengthValid) {
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
    // ensures inputs are not empty and password is long enough
    private func validateUserSignUp() {
        isUserNameEmpty = username.isEmpty
        isPasswordEmpty = password.isEmpty
        
        let isPasswordLengthValid = isPasswordValid(password)
        
        if (!isUserNameEmpty && !isPasswordEmpty && isPasswordLengthValid) {
            
            /* hash the password from plaintext */
            let hashedpassword = hashPassword(password)
            
            password = hashedpassword
            
            /* Prepare user and password as json string */
            let userPayload: [String: Any] = ["username": username, "password": password]
            
            do {
                // Serialize the dictionary to JSON data
                let jsonData = try JSONSerialization.data(withJSONObject: userPayload, options: [])
                
                /* API call to create new user*/
                ClientServer.shared.testLoad(url: "/user/signup", method: "POST", payload: jsonData) { result in
                    
                    switch result {
                    case .success(let responseString):
                        print("Response: \(responseString)")
                        /* If returns with status 200 then submittedSignUp to true*/
                        submittedSignUp = true
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
struct CustomTextFColor: View {
    var nameHolder: String
    @Binding var text: String
    @Binding var emptyCheck: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            //if the text is empty then it will preview the text hold name with the color
            if (text.isEmpty) {
                Text(nameHolder)
                    .foregroundColor(.gray)
                    .padding(.top, -10)
                    .padding(.leading, 6)
            }
            //text input for user
            TextField("", text: $text)
                .padding(.top, -10)
                .padding(.leading, 6)
                .frame(height: 50)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(4)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(emptyCheck ? Color.red : Color.clear, lineWidth: 1)
                )
        }
    }
}

struct CustomerUserName: View {
    @Binding var username: String
    @Binding var isUserNameEmpty: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Username *")
                .foregroundColor(.black)
            //need the first and last name side to side->horizontal
            HStack {
                //call the funtion here
                CustomTextFColor(nameHolder: "user", text: $username, emptyCheck: $isUserNameEmpty)
            }
        }
    }
}

struct CustomerPassword: View {
    @Binding var password: String
    @Binding var isPasswordEmpty: Bool
    @State private var isPasswordLengthValid = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Password *")
                .font(.subheadline)
                .foregroundColor(.black)
            //call the function here
            CustomTextFColor(nameHolder: "", text: $password, emptyCheck: $isPasswordEmpty)
            //the .onChange will be trigger everytime the specifed value changes
                .onChange(of: password) {
                    //call the function to check if the email is valid
                    isPasswordLengthValid = isPasswordValid(password)
                }
            //this error will only display if the email is not valid and also if the email is not empty
            if (!isPasswordLengthValid && !password.isEmpty) {
                Text("Please enter a valid password that is 7 or more characters long.")
                    .font(.footnote)
                    .foregroundColor(.black)
            }
        }
    }
}
    // ensures password is long enough
    func isPasswordValid(_ password: String) -> Bool {
        let passwordLength = password.count
        if (passwordLength < 7) {
            return false
        } else {
            return true
        }
    }
    
    // converts password to hash
    func hashPassword(_ password: String) -> String {
        // Convert the password string to Data
        guard let data = password.data(using: .utf8) else {
            return ""
        }
        
        // Create a buffer for the hash
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        
        // Perform the hashing
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        
        // Convert the hash to a hexadecimal string
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
