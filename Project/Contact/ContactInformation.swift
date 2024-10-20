//
//  ContactInformation.swift
//  Project
//
//  Created by Christian Hernandez on 10/19/24.
//

import SwiftUI

struct ContactInformation: View {
    var body: some View {
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            ScrollView {
                //information is vertical-> text, then the name, email, subject, and message but in they are horizontal so you create HStack inside, will have a leading space of 20 from the far left
                VStack(alignment: .leading, spacing: 20) {
                    Text("Get in Touch With Us")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        //center this 
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 60)
                        .padding(.bottom, 30)
                    //now call the name struct information-> user input
                    CustomerName()
                    //now call the email struct information-> user input
                    CustomerEmail()
                    //now call the subject struct-> user input
                    CustomerSubjectEmail()
                    //lastly call the message struct-> user input
                    CustomerMessage()
                    //create the button so it gives the option for user to send
                    Button(action: {
                        
                    }){
                        Text("Send Message")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .padding(.top, 0)
                    .padding(.bottom, 20)
                }
                .padding(.horizontal)
                //THIS GOES OUT THE VSTACK SINCE IT IS ONLY THE FORMAT OF THE DIVIDER AND VSTACK IS ALIGNMENTING THE FORMATION, THIS INFORMATION BELOW SHOULD NOT BE ALIGNMENT
                //another divider for the second line
                Divider()
                    .frame(height: 6)
                    .background(Color.gray.opacity(0.3))
                    .padding(.top, 5)
                
                //add the instagram link and youtube link-> has to be side to side so use HStack-> horizontal
                HStack{
                    //call the struct-> pass in the two parameters which are image and url
                    InstagramAndYoutubeLink(socialMediaImage: "instagramimage", url: "https://www.instagram.com/yeseniadesigns/")
                        .padding(.top, 100)
                        .padding(.bottom, 20)
                    InstagramAndYoutubeLink(socialMediaImage: "youtubeimage", url: "https://www.youtube.com/@yeseniadesigns")
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
}
//precondition: NONE
//postcondition: this struct is going to be able to print the name first and last horizontally
struct CustomerName: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Name *")
                .foregroundColor(.black)
            //need the first and last name side to side->horizontal
            HStack {
                //vertical-> the information first then the input for user
                VStack(alignment: .leading) {
                    Text("First")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    //TextField->lets user input
                    TextField("First",text: .constant(""))
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                }
                //this is for the second box-> last name
                VStack(alignment: .leading) {
                    Text("Last")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    TextField("Last",text: .constant(""))
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                }
            }
        }
    }
}
//precondition: NONE
//postcondition: this struct gets the customer email-> must be vstack with email first then the text box
struct CustomerEmail: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Email *")
                .font(.subheadline)
                .foregroundColor(.black)
            TextField("Email", text: .constant(""))
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .foregroundColor(.black)
        }
    }
}
//precondition: NONE
//postcondition: this struct lets customer enter the subject of the email
struct CustomerSubjectEmail: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Subject *")
                .font(.subheadline)
                .foregroundColor(.black)
            TextField("",text: .constant(""))
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .foregroundColor(.black)
        }
    }
}
//precondition: NONE
//postcondition: this struct is going to let customer enter the message
struct CustomerMessage: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Message *")
                .font(.subheadline)
                .foregroundColor(.black)
            TextField("",text: .constant(""))
                .frame(height: 200)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .foregroundColor(.black)
        }
        
    }
}

//lets me see the updates (just a preview of the code you are doing)
struct ContactInformation_Previews: PreviewProvider {
    static var previews: some View {
        ContactInformation()
    }
}
