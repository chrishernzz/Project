//
//  ContactInformation.swift
//  Project
//
//  Created by Christian Hernandez on 10/19/24.
//
import Foundation
import SwiftUI

struct ContactInformation: View {
    //@state is the parent view where the actual data is stored and managed
    @State private var submittedMessage = false
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var subject = ""
    @State private var message: String = ""
    @State private var isFirstNameEmpty = false
    @State private var isLastNameEmpty = false
    @State private var isEmailEmpty = false
    @State private var isSubjectEmpty = false
    @State private var isMessageEmpty = false
    
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
                    if (submittedMessage){
                        Text("Thank you. Your information has been submitted.")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .padding(.bottom)
                    }
                    else{
                        //now call the name struct information-> user input
                        CustomerName(firstName: $firstName, lastName: $lastName, isFirstNameEmpty: $isFirstNameEmpty, isLastNameEmpty: $isLastNameEmpty)
                            .padding(.top, -50)
                        //now call the email struct information-> user input
                        CustomerEmail(email: $email, isEmailEmpty: $isEmailEmpty)
                        //now call the subject struct-> user input
                        CustomerSubjectEmail(subject: $subject, isSubjectEmpty: $isSubjectEmpty)
                        //lastly call the message struct-> user input
                        CustomerMessage(message: $message, isMessageEmpty: $isMessageEmpty)
                        //create the button so it gives the option for user to send-> action will let us flag anything once the user clicks send message(the button)
                        Button(action: {
                            //call the function once users sends the message
                            validateUserInputs()
                        }){
                            Text("Send Message")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        .padding(.top, 0)
                        .padding(.bottom, 20)
                        //check if the any of the validation is empty if so then error-> if any are true that are empty then print the error
                        if (isFirstNameEmpty || isLastNameEmpty || isEmailEmpty || isSubjectEmpty || isMessageEmpty) {
                            //print an error
                            Text("Please correct the highlighted fields")
                                .padding(.top, -30)
                                .foregroundColor(.black)
                                .font(.footnote)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top , 20)
                //THIS GOES OUT THE VSTACK SINCE IT IS ONLY THE FORMAT OF THE DIVIDER AND VSTACK IS ALIGNMENTING THE FORMATION, THIS INFORMATION BELOW SHOULD NOT BE ALIGNMENT
                //another divider for the second line
                Divider()
                    .frame(height: 6)
                    .background(Color.gray.opacity(0.3))
                    .padding(.top, 5)
                
                //add the instagram link and youtube link-> has to be side to side so use HStack-> horizontal
                HStack{
                    //call the struct-> pass in the two parameters which are image and url
                    InstagramAndYoutubeLink(socialMediaImage: "instagramimage", url: URL(string:"https://www.instagram.com/yeseniadesigns/")!)
                        .padding(.top, 100)
                        .padding(.bottom, 20)
                    InstagramAndYoutubeLink(socialMediaImage: "youtubeimage", url: URL(string: "https://www.youtube.com/@yeseniadesigns")!)
                        .padding(.top, 100)
                        .padding(.bottom, 20)
                }
                //lastly just place the information of her company
                Text("© 2012-2024 YESENIA DESIGNS. ALL RIGHTS RESERVED.")
                    .font(.caption)
                //.regular doesn't make it as bold
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                //have to center the text
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    //precondition: NONE
    //postcondition: going to check if the input is not empty, if that is true then submittedMessage is true->shows the message then we clear the screen
    private func validateUserInputs() {
        //flag the variables to empty
        isFirstNameEmpty = firstName.isEmpty
        isLastNameEmpty = lastName.isEmpty
        isEmailEmpty = email.isEmpty
        isSubjectEmpty = subject.isEmpty
        isMessageEmpty = message.isEmpty
        //create a constant to make sure the email is valid and you call the function
        let isEmailValid = !isValidEmail(email)
        
        //if all variables are not empty (fill in) run this and call the clearValidFields()
        if (!isFirstNameEmpty && !isLastNameEmpty && !isEmailEmpty && !isEmailValid && !isSubjectEmpty && !isMessageEmpty) {
            //flag it to true so now it will show the message
            submittedMessage = true
            //clear the input after-> by doing this you set everything to empty strings(call the function)
            clearValidFields()
        }
    }
    //just clears the information once everything is valid
    private func clearValidFields() {
        firstName = ""
        lastName = ""
        email = ""
        subject = ""
        message = ""
    }
}
//precondition: NONE
//postcondition: going to create a function that controls the light mode and dark mode
struct CustomTextFieldColor: View {
    var nameHolder: String
    //@binding allows two way connection between the parent view and child view, any changes made in the child will update the parents data
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
//precondition: call the CustomTextFieldColor to make sure the color is correct
//postcondition: this struct is going to be able to print the name first and last horizontally
struct CustomerName: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var isFirstNameEmpty: Bool
    @Binding var isLastNameEmpty: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Name *")
                .foregroundColor(.black)
            //need the first and last name side to side->horizontal
            HStack {
                //call the funtion here
                CustomTextFieldColor(nameHolder: "First", text: $firstName, emptyCheck: $isFirstNameEmpty)
                CustomTextFieldColor(nameHolder: "Last", text: $lastName, emptyCheck: $isLastNameEmpty)
            }
        }
    }
}

//precondition: going to pass in a parameter that will indicate the email
//postcondition: going to return true if the email contains '@' else false
func isValidEmail(_ email: String) -> Bool {
    // Regular expression to validate email
    let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3,}$"
    //predicate will filter the results-> will filter the fetcching
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailTest.evaluate(with: email)
}
//precondition: NONE
//postcondition: this struct gets the customer email-> must be vstack with email first then the text box
struct CustomerEmail: View {
    @Binding var email: String
    @Binding var isEmailEmpty: Bool
    @State private var isEmailValid: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Email *")
                .font(.subheadline)
                .foregroundColor(.black)
            //call the function here
            CustomTextFieldColor(nameHolder: "", text: $email, emptyCheck: $isEmailEmpty)
            //the .onChange will be trigger everytime the specifed value changes
                .onChange(of: email) {
                    //call the function to check if the email is valid
                    isEmailValid = isValidEmail(email)
                }
            //this error will only display if the email is not valid and also if the email is not empty
            if (!isEmailValid && !email.isEmpty) {
                Text("Please enter a valid email address.")
                    .font(.footnote)
                    .foregroundColor(.black)
            }
        }
    }
}

//precondition: NONE
//postcondition: this struct lets customer enter the subject of the email
struct CustomerSubjectEmail: View {
    @Binding var subject: String
    @Binding var isSubjectEmpty: Bool
    var body: some View {
        VStack(alignment: .leading) {
            Text("Subject *")
                .font(.subheadline)
                .foregroundColor(.black)
            CustomTextFieldColor(nameHolder: "", text: $subject, emptyCheck: $isSubjectEmpty)
        }
    }
}
//precondition: NONE
//postcondition: this struct is going to let customer enter the message
struct CustomerMessage: View {
    //prevents us from using a parameter and keeps it within the view
   // @State private var message: String = ""
   // @State private var isMessageEmpty = false
    
    @Binding var message: String
    @Binding var isMessageEmpty: Bool
    var body: some View {
        VStack(alignment: .leading) {
            Text("Message *")
                .font(.subheadline)
                .foregroundColor(.black)
            ZStack(alignment: .topLeading) {
                //going to make sure it allows multilines since it is a message
                TextField("", text: $message, axis: .vertical)
                    .padding(.leading, 8)
                    .padding(.top, -65)
                    .frame(height: 150)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(isMessageEmpty ? Color.red : Color.clear, lineWidth: 1)
                    )
                    .onChange(of: message) {
                        isMessageEmpty = message.isEmpty
                    }
                    .foregroundColor(Color.black)
            }
            
        }
    }
}


//lets me see the updates (just a preview of the code you are doing)
struct ContactInformation_Previews: PreviewProvider {
    static var previews: some View {
        ContactInformation()
    }
}
