//
//  SignUpForm.swift
//  Project
//
//  Created by Isaiah Vogt on 11/27/24.
//

import Foundation
import SwiftUI
import CommonCrypto


struct AuthForm: View {
    /* Used for state update/change */
    /* Sign Up */
    @State private var submittedSignUp = false
    @State private var isSignUpUserNameEmpty = false
    @State private var isSignUpPasswordEmpty = false
    @State private var isPasswordLengthValid = false
    @State private var signUpUsername = ""
    @State private var signUpPassword = ""
    
    /* Login */
    @State private var validLogIn = false
    @State private var isLogInUserNameEmpty = false
    @State private var isLogInPasswordEmpty = false
    @State private var logInUsername = ""
    @State private var logInPassword = ""
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            ScrollView {
                HStack {
                    // Sign Up Form
                    VStack(alignment: .leading, spacing: 20) {
                        LinearGradient(
                            gradient: Gradient(colors: [Color.pink.opacity(0.2), Color.white]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, -16)

                        Text("Get in Touch With Us")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, -100)

                        if submittedSignUp {
                            Text("Thank you. Your account has been created.")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                                .padding(.bottom)
                        } else {
                            CustomerUserName(username: $signUpUsername, isUserNameEmpty: $isSignUpUserNameEmpty)
                                .padding(.top, -50)
                            CustomerPassword(password: $signUpPassword, isPasswordEmpty: $isSignUpPasswordEmpty)

                            Button(action: { validateUserSignUp() }) {
                                Text("Sign Up")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black)
                                    .cornerRadius(10)
                            }
                            .padding(.top, 0)
                            .padding(.bottom, 20)

                            if isSignUpUserNameEmpty || isSignUpPasswordEmpty {
                                Text("Please correct the highlighted fields")
                                    .padding(.top, -30)
                                    .foregroundColor(.black)
                                    .font(.footnote)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)

                    // Log In Form
                    VStack(alignment: .leading, spacing: 20) {
                        LinearGradient(
                            gradient: Gradient(colors: [Color.pink.opacity(0.2), Color.white]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, -16)

                        Text("Log In")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, -100)

                        if validLogIn {
                            Text("You are now logged in.")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                                .padding(.bottom)
                        } else {
                            LoginUserName(username: $logInUsername, isUserNameEmpty: $isLogInUserNameEmpty)
                                .padding(.top, -50)
                            LoginPassword(password: $logInPassword, isPasswordEmpty: $isLogInPasswordEmpty)

                            Button(action: { validateUserLogin() }) {
                                Text("Log in")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black)
                                    .cornerRadius(10)
                            }
                            .padding(.top, 0)
                            .padding(.bottom, 20)

                            if isLogInUserNameEmpty || isLogInPasswordEmpty {
                                Text("Please correct the highlighted fields")
                                    .padding(.top, -30)
                                    .foregroundColor(.black)
                                    .font(.footnote)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                .padding(.horizontal)
                // Reuse the function that goes after all the information
                InformationAfterImages()
            }
        }
    }
    // ensures inputs are not empty and password is long enough
    private func validateUserSignUp() {
        isSignUpUserNameEmpty = signUpUsername.isEmpty
        isSignUpPasswordEmpty = signUpPassword.isEmpty
        
        let isPasswordLengthValid = isPasswordValid(signUpPassword)
        
        if (!isSignUpUserNameEmpty && !isSignUpPasswordEmpty && isPasswordLengthValid) {
            
            /* hash the password from plaintext */
            let hashedpassword = hashPassword(signUpPassword)
            
            signUpPassword = hashedpassword
            
            /* Prepare user and password as json string */
            let userPayload: [String: Any] = ["username": signUpUsername, "password": signUpPassword]
            
            do {
                /* API call to create new user*/
                ClientServer.shared.testLoad(url: "/user/signup", method: "POST", payload: userPayload) { result in
                    
                    switch result {
                    case .success(let responseString):
                        // TODO: remove this
                        print("Response: \(responseString)")
                        /* Get and Store token */
                        // Parse the response to extract the token
                        if let data = responseString.data(using: .utf8) {
                            do {
                                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                                   let token = json["token"] as? String {
                                    
                                    // Store token in UserDefaults
                                    UserDefaults.standard.set(token, forKey: "authToken")
                                    
                                    print("Token saved: \(token)")
                                    
                                    // If returns with status 200, update submittedSignUp
                                    submittedSignUp = true
                                    clearValidFields()
                                } else {
                                    print("Token not found in response.")
                                }
                            } catch {
                                print("Failed to parse response: \(error.localizedDescription)")
                            }
                        }
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
            } catch {
                print("Error serializing JSON: \(error.localizedDescription)")
            }
        }
    }
    
    // ensures are not empty
    private func validateUserLogin() {
        isLogInUserNameEmpty = logInUsername.isEmpty
        isLogInPasswordEmpty = logInPassword.isEmpty
        
        if(!isLogInUserNameEmpty && !isLogInPasswordEmpty) {
            
            /* hash the password from plaintext. This function is located in the sister file SignUpForm.swift */
            let hashedpassword = hashPassword(logInPassword)
            
            logInPassword = hashedpassword
            
            /* Prepare user and password as json string */
            let userPayload: [String: Any] = ["username": logInUsername, "password": logInPassword]
            
            do {
                // API call to log in user
                ClientServer.shared.testLoad(url: "/user/login", method: "POST", payload: userPayload) { result in
                    
                    switch result {
                    case .success(let responseString):
                        print("Response: \(responseString)")
                        
                        // Parse the response to extract the token
                        if let data = responseString.data(using: .utf8) {
                            do {
                                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                                   let token = json["token"] as? String {
                                    
                                    // Store token in UserDefaults
                                    UserDefaults.standard.set(token, forKey: "authToken")
                                    
                                    print("Token saved: \(token)")
                                    
                                    // If returns with status 200, update validLogIn
                                    validLogIn = true
                                    clearValidFields()
                                } else {
                                    print("Token not found in response.")
                                }
                            } catch {
                                print("Failed to parse response: \(error.localizedDescription)")
                            }
                        }
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                        // Handle login failure (e.g., show an error message)
                    }
                }
            } catch {
                print("Error serializing JSON: \(error.localizedDescription)")
            }
        }
    }
    
    private func clearValidFields() {
        signUpUsername = ""
        signUpPassword = ""
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
