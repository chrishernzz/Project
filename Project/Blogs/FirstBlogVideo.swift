//
//  FirstBlogVideo.swift
//  Project
//
//  Created by Christian Hernandez on 12/4/24.
//

import SwiftUI


struct FirstBlogVideo: View {
    var body: some View {
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            //Call the main first blog here
            FirstBlogVideoMain()
        }
    }
}


//precondition: NONE
//postcondition: this struct will be reuse in the main and also if user wants to reply to a comment
struct FirstBlogVideoMain: View {
    //allows the UI to change-> will only be access within this view
    @State private var isHovered = false
    @State private var incrementLike = 0
    @State private var incrementComment = 0
    @State private var currentView  = false
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Vlog: Darts on Board Final Project (Dart Manipulation on Front Bodice)")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.leading, 170)
            HStack (spacing: 5) {
                Text("11/30/2024")
                    .foregroundColor(.black)
                    .padding(.leading, 170)
                Button(action: {
                    //flag this to true so it can go to the struct that allows user to comment
                    currentView = true
                }) {
                    Text("\(incrementComment) Comments")
                        .foregroundColor(isHovered ?  Color(red: 0.9, green: 0.39, blue: 0.64)  : .black)
                        .underline()
                }
                .onHover { hovering in
                    isHovered = hovering // Update hover state
                }
                .buttonStyle(BorderlessButtonStyle()) // Avoid default button behavior
            }
            //add the video
            WebView(url: URL(string: "https://www.youtube.com/embed/Qbq01KvOFz0")!)
                .frame(height: 250)
                .padding(.horizontal, 22)
                .padding(.leading, 150)
            Text("Come along as I work on my second final project for my pattern making and design 1 class. We had to manipulate the dart on the front bodice 9 times and create a 3D model of them and display them on a board and this is how mine turned out! Did I create more work for myself by retracing and creating an embroidery file out of them? Yes, I did haha but it was fun creating my own textiles with my embroidery machine that it gave me some ideas for future designs/projects!")
                .font(.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 25)
                .padding(.leading, 150)
            HStack(spacing: 10) {
                //this button is for the link
                Button(action: {
                    //add one to it
                    incrementLike += 1
                }) {
                    //you want to add a frame then on top (ZStack-> layered top of another) lets us then add the information in the frame
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 80, height: 25)
                            .background(.blue)
                        HStack(spacing: 5) {
                            Image(systemName: "hand.thumbsup.fill")
                                .foregroundColor(.white)
                            Text("Like \(incrementLike)")
                                .foregroundColor(.white)
                                .font(.subheadline)
                        }
                    }
                    .padding(.leading,190)
                }
            }
        }
        //this will now be true so it will create a full screen then show the playlist-> Sewing Playlist
        .fullScreenCover(isPresented: $currentView) {
            FirstBlogComments()
        }
    }
}

//precondition: call the FirstBlogVideoMain(), reusing
//postcondition: going to allow the user to enter comments with the requirements of having name and comments
struct FirstBlogComments: View {
    @State private var submittedMessage = false
    @State private var name = ""
    @State private var email = ""
    @State private var website = ""
    @State private var comments = ""
    @State private var isNameEmpty = false
    @State private var isCommentsEmpty = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                //this button will be a dismiss and go back to the main menu
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        Text("Return to Blog")
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding()
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        //have to adjust the padding
                        FirstBlogVideoMain()
                            .padding(.leading, -150)
                        Text("Leave a Reply.")
                            .foregroundColor(.black)
                            .font(.title2)
                            .padding(.horizontal, 20)
                            .padding(.top, 30)
                        //if user does send the comment then it is true
                        if (submittedMessage){
                            Text("Your comment was successfully posted.")
                                .foregroundColor(.black)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.bottom)
                                .padding(.horizontal, 20)
                                .padding(.top, 20)
                        }
                        else {
                            //call the information of all the structs you created
                            NameComment(name: $name, isNameEmpty: $isNameEmpty)
                                .padding(.horizontal, 20)
                            EmailComment(email: $email)
                                .padding(.horizontal, 20)
                            WebsiteComment(website: $website)
                                .padding(.horizontal, 20)
                            UserComments(comment: $comments, isCommentEmpty: $isCommentsEmpty)
                                .padding(.horizontal, 20)
                            
                            Button(action: {
                                validateUserInputs()
                            }) {
                                Text("Submit")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black)
                                    .cornerRadius(8)
                                    .padding(.leading, 280)
                            }
                            if (isNameEmpty || isCommentsEmpty) {
                                Text("Please correct the highlighted fields")
                                    .foregroundColor(.red)
                                    .font(.footnote)
                                    .padding(.horizontal, 20)
                                    .padding(.top,-80)
                            }
                            
                            
                        }
                        
                    }
                }
            }
        }
    }
    //precondition: NONE
    //postcondition: going to check if the input is not empty, if that is true then submittedMessage is true->shows the message then we clear the screen
    private func validateUserInputs() {
        isNameEmpty = name.isEmpty
        isCommentsEmpty = comments.isEmpty
        
        if (!isNameEmpty && !isCommentsEmpty) {
            submittedMessage = true
            clearValidFields()
        }
    }
    //just clears the information once everything is valid
    private func clearValidFields() {
        name = ""
        email = ""
        website = ""
        comments = ""
    }
}
//precondition: NONE
//postcondition: going to create a function that controls the light mode and dark mode
struct CustomTextFieldColorComment: View {
    //@binding allows two way connection between the parent view and child view, any changes made in the child will update the parents data
    @Binding var text: String
    var body: some View {
        VStack {
            //text input for user
            TextField("", text: $text)
                .padding(.horizontal, 45)
                .frame(height: 45)
                .background(Color.white)
                .cornerRadius(4)
                .foregroundColor(.black)
        }
    }
}

//precondition: use the CustomTextFieldColorComment for the editing of the box
//postcondition: this struct will allow user to enter their name (must entered)
struct NameComment: View {
    @Binding var name: String
    @Binding var isNameEmpty: Bool
    var body: some View {
        VStack(alignment: .leading){
            Text("Name (required)")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .padding(.leading, 0)
            //call the funtion here
            CustomTextFieldColorComment(text: $name)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(isNameEmpty ? Color.red : Color.gray, lineWidth: 1)
                )
        }
    }
}
//precondition: use the CustomTextFieldColorComment for the editing of the box
//postcondition: this struct will allow user to enter their email (if they want)
struct EmailComment: View {
    @Binding var email: String
    var body: some View {
        VStack(alignment: .leading){
            Text("Email (not published)")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .padding(.leading, 0)
            //call the funtion here
            CustomTextFieldColorComment(text: $email)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
    }
}
//precondition: use the CustomTextFieldColorComment for the editing of the box
//postcondition: this struct will allow user to enter their email (if they want)
struct WebsiteComment: View {
    @Binding var website: String
    var body: some View {
        VStack(alignment: .leading){
            Text("Website")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .padding(.leading, 0)
            //call the funtion here
            CustomTextFieldColorComment(text: $website)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
    }
}
//precondition: use the CustomTextFieldColorComment for the editing of the box
//postcondition: this struct will allow user to enter their comments (must entered)
struct UserComments: View {
    @Binding var comment: String
    @Binding var isCommentEmpty: Bool
    var body: some View {
        VStack(alignment: .leading){
            Text("Comments (required)")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .padding(.leading, 0)
            //call the funtion here
            CustomTextFieldColorComment(text: $comment)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(isCommentEmpty ? Color.red : Color.gray, lineWidth: 1)
                )
        }
    }
}


//lets me see the updates (just a preview of the code you are doing)
struct FirstBlog_Preview: PreviewProvider {
    static var previews: some View {
        FirstBlogComments()
    }
}

