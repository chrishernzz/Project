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
    @State private var message = ""
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
                //this will start off white and then
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 1.0, green: 0.94, blue: 0.96), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 400)
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
                .padding(.top , -200)
                //going to reuse the function that goes after all the information
                InformationAfterImages()
            }
        }
    }
    //precondition: NONE
    //postcondition: going to check if the input is not empty, if that is true then submittedMessage is true->shows the message then we clear the screen
    private func validateUserInputs() {
        sendInquiry(name: firstName, email: email, subject: subject, message: message) { inquiry in
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

struct Inquiry: Identifiable, Codable {
    var id: String
    var name: String
    var email: String
    var subject: String
    var message: String
}

/* API Request to create contact inquiry. */
func sendInquiry(name: String, email: String, subject: String, message: String, completion: @escaping (Inquiry?) -> Void) {
    
    // Generate a unique ID
    let uniqueId = UUID().uuidString
    
    /* Prepare bullshit payload. */
    let pay: [String: Any] = ["id": uniqueId, "name": name, "email": email, "subject": subject, "message": message]
    
    ClientServer.shared.testLoad(url: "/contact", method: "POST", payload: pay) {
        result in
        
        switch result {
        case .success(let responseString):
            if let data = responseString.data(using: .utf8) {
                do {
                    let inquiry = try JSONDecoder().decode(Inquiry.self, from: data)
                    completion(inquiry)
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    completion(nil) // Return nil in case of error
                }
            } else {
                print("Error converting response string to data")
                completion(nil) // Return nil if conversion fails
            }
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
            completion(nil) // Call completion with nil on error
        }
        
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
    //predicate will filter the results-> will filter the fetching
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    //return true if email is valid
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

