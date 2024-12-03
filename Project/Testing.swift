//
//  Testing.swift
//  Project
//
//  Created by Daniel Hernandez on 12/2/24.
//
import SwiftUI

struct Testing: View {
    // State to toggle between "Log In" and "Sign Up"
    @State private var isShowingSignUp = false

    // States for Log In
    @State private var logInUsername = ""
    @State private var logInPassword = ""
    @State private var isLogInUserNameEmpty = false
    @State private var isLogInPasswordEmpty = false

    // States for Sign Up
    @State private var signUpUsername = ""
    @State private var signUpPassword = ""
    @State private var isSignUpUserNameEmpty = false
    @State private var isSignUpPasswordEmpty = false
    @State private var submittedSignUp = false

    var body: some View {
        ZStack {
            Color(.white).edgesIgnoringSafeArea(.all) // Consistent background color
            VStack {
                if isShowingSignUp {
                    // Sign Up View
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Sign Up")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)

                        if submittedSignUp {
                            Text("Thank you. Your account has been created.")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        } else {
                            CustomerUserName(username: $signUpUsername, isUserNameEmpty: $isSignUpUserNameEmpty)
                            CustomerPassword(password: $signUpPassword, isPasswordEmpty: $isSignUpPasswordEmpty)

                            Button(action: {
                                validateUserSignUp()
                            }) {
                                Text("Sign Up")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(5)
                            }
                            .padding(.top)

                            if isSignUpUserNameEmpty || isSignUpPasswordEmpty {
                                Text("Please correct the highlighted fields")
                                    .foregroundColor(.red)
                                    .font(.footnote)
                            }
                        }

                        Spacer()

                        // Button to switch back to Log In view
                        Button(action: {
                            isShowingSignUp = false
                        }) {
                            Text("Already have an account? Log In")
                                .foregroundColor(.blue)
                                .font(.footnote)
                        }
                    }
                    .padding()
                } else {
                    // Log In View
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Log In")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)

                        LoginUserName(username: $logInUsername, isUserNameEmpty: $isLogInUserNameEmpty)
                        LoginPassword(password: $logInPassword, isPasswordEmpty: $isLogInPasswordEmpty)

                        Button(action: {
                            validateUserLogin()
                        }) {
                            Text("Log In")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(5)
                        }
                        .padding(.top)

                        if isLogInUserNameEmpty || isLogInPasswordEmpty {
                            Text("Please correct the highlighted fields")
                                .foregroundColor(.red)
                                .font(.footnote)
                        }

                        Spacer()

                        // Button to switch to Sign Up view
                        Button(action: {
                            isShowingSignUp = true
                        }) {
                            Text("Don't have an account? Sign Up")
                                .foregroundColor(.blue)
                                .font(.footnote)
                        }
                    }
                    .padding()
                }
            }
        }
    }

    // Sign Up validation logic
    private func validateUserSignUp() {
        isSignUpUserNameEmpty = signUpUsername.isEmpty
        isSignUpPasswordEmpty = signUpPassword.isEmpty

        if !isSignUpUserNameEmpty && !isSignUpPasswordEmpty {
            submittedSignUp = true
            clearValidFields()
        }
    }

    // Log In validation logic
    private func validateUserLogin() {
        isLogInUserNameEmpty = logInUsername.isEmpty
        isLogInPasswordEmpty = logInPassword.isEmpty

        if !isLogInUserNameEmpty && !isLogInPasswordEmpty {
            // Log In successful
            print("Log In successful")
        }
    }

    // Clear fields after successful action
    private func clearValidFields() {
        signUpUsername = ""
        signUpPassword = ""
    }
}

struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing()
    }
}

