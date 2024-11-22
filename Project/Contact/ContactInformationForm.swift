//
//  ContactInformationForm.swift
//  Project
//
//  Created by Christian Hernandez on 11/20/24.
//
import Foundation
import SwiftUI

//precondition: going to first check if the user input is valid or not, if not then don't send message, also calling the function to reuse
//postcondition: this struct is for the contact information when user needs to contact owner
struct ContactInformationForm: View {
    //passing in one parameter which is binding-> this is the child and it allows two way data connection
    @Binding var showForm: Bool
    //private variables for only contact information
    @State private var name = ""
    @State private var email = ""
    @State private var subject = ""
    @State private var message = ""
    @State private var showConfirmationMessage = false
    @State private var isNameEmpty = false
    @State private var isEmailEmpty = false
    @State private var isSubjectEmpty = false
    @State private var isMessageEmpty = false
    
    var body: some View {
        //need a layered on top of another because it has to be transparent
        ZStack {
            //semi-transparent background that covers the entire screen
            Color.black.opacity(0.6).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                ZStack(alignment: .topTrailing) {
                    //if they send message ->true then run this
                    if (showConfirmationMessage) {
                        //vertical so we can print the message out
                        VStack {
                            Text("Thank you for contacting us.")
                                .font(.headline)
                                .padding(.top, 20)
                                .foregroundColor(.black)
                                .colorScheme(.light)
                            Text("Your message has been submitted and we will be in touch with you as soon as possible.")
                                .multilineTextAlignment(.center)
                                .padding(.vertical, 10)
                                .foregroundColor(.black)
                                .colorScheme(.light)
                            Button(action: {
                                //flag it back to false -> closed the form
                                showForm = false
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.gray)
                                    .font(.title)
                                    .padding([.top, .trailing], 20)
                            }
                        }
                        .padding(30)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal, 20)
                    }
                    else {
                        //each box will have a 5 space gap in between
                        VStack(spacing: 5) {
                            //call the customTextFieldColor (reusing) function
                            CustomTextFieldColor(nameHolder: "Your name", text: $name, emptyCheck: $isNameEmpty)
                            CustomTextFieldColor(nameHolder: "Your email address", text: $email, emptyCheck: $isEmailEmpty)
                            CustomTextFieldColor(nameHolder: "Subject", text: $subject, emptyCheck: $isSubjectEmpty)
                            ZStack(alignment: .topLeading) {
                                if (message.isEmpty) {
                                    Text("Message...")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                        .padding(.top, 10)
                                }
                                //going to make sure it allows multilines since it is a message
                                TextField("", text: $message, axis: .vertical)
                                    .padding(.leading, 8)
                                    .padding(.top, -40)
                                    .frame(height: 100)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(isMessageEmpty ? Color.red : Color.clear, lineWidth: 1)
                                    )
                                    .onChange(of: message) {
                                        isMessageEmpty = message.isEmpty
                                    }
                                    .foregroundColor(Color.black)
                            }
                            HStack {
                                Spacer()
                                Button(action: {
                                    //call the validation function to determine if the message if filled with all the information
                                    validateUserInputs()
                                    
                                }) {
                                    Text("Send")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .background(Color.pink.opacity(0.2))
                                        .cornerRadius(5)
                                }
                            }
                            //check if the any of the validation is empty if so then error-> if any are true that are empty then print the error
                            if (isNameEmpty || isEmailEmpty || isSubjectEmpty || isMessageEmpty) {
                                //print an error
                                Text("Please correct the highlighted fields")
                                    .foregroundColor(.black)
                                    .font(.footnote)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 50)
                    }
                    //close button (only for form)
                    if (!showConfirmationMessage) {
                        Button(action: {
                            showForm = false
                        }) {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.gray)
                                .font(.title)
                                .padding([.top, .trailing], 20)
                        }
                    }
                }
                Spacer()
            }
        }
    }
    //precondition: NONE
    //postcondition: going to check if the input is not empty, if that is true then submittedMessage is true->shows the message then we clear the screen
    private func validateUserInputs() {
        //flag the variables to empty
        isNameEmpty = name.isEmpty
        isEmailEmpty = email.isEmpty
        isSubjectEmpty = subject.isEmpty
        isMessageEmpty = message.isEmpty
        
        //if all variables are not empty (fill in) run this and call the clearValidFields()
        if (!isNameEmpty && !isEmailEmpty && !isSubjectEmpty && !isMessageEmpty) {
            //flag it to true so now it will show the message
            showConfirmationMessage = true
            //clear the input after-> by doing this you set everything to empty strings(call the function)
            clearValidFields()
        }
    }
    //just clears the information once everything is valid
    private func clearValidFields() {
        name = ""
        email = ""
        subject = ""
        message = ""
    }
}
