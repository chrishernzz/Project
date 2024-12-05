//
//  BlogVideoInformation.swift
//  Project
//
//  Created by Chrisitan Hernandez on 12/4/24.
//

import SwiftUI


struct BlogVideoInformation: View {
    //one parameter that takes in an array of the blog information
    @Binding var blogs: [BlogItems]
    
    //this will determine what blog the user wants based on what they click-> it is currently empty (no value)
    @State private var selectedBlogIndex: SelectedBlogIndex? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            //create an array of blogs with enums-> this will start at 0... and increased depedning on the blogs videos
            ForEach(Array(blogs.enumerated()), id: \.offset) {index, item in
                Button(action: {
                    //you now have to set the index-> call the struct and passed in the index for the value (Ex if index is 0-> value will have 0)
                    selectedBlogIndex = SelectedBlogIndex(value: index)
                }) {
                    Text(item.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.leading, 165)
                }
                HStack (spacing: 5) {
                    Text(item.date)
                        .foregroundColor(.black)
                        .padding(.leading, 170)
                    Button(action: {
                        //you now have to set the index-> call the struct and passed in the index for the value (Ex if index is 0-> value will have 0)
                        selectedBlogIndex = SelectedBlogIndex(value: index)
                    }) {
                        Text("\(blogs[index].commentCount) Comments")
                            .foregroundColor(.black)
                            .underline()
                    }
                }
                //add the video-> reuse the webview struct that was created earlier
                WebView(url: item.video)
                    .frame(height: 250)
                    .padding(.horizontal, 22)
                    .padding(.leading, 150)
                Text(item.description)
                    .font(.body)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 25)
                    .padding(.leading, 150)
                
                HStack(spacing: 10) {
                    Button(action: {
                        //this will now keep track of each video with their likes, you have to pass in the index
                        blogs[index].likeCount += 1
                    }) {
                        //you want to add a frame then on top (ZStack-> layered top of another) lets us then add the information in the frame
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 80, height: 25)
                                .background(.blue)
                            HStack(spacing: 5) {
                                Image(systemName: "hand.thumbsup.fill")
                                    .foregroundColor(.white)
                                Text("Like \(blogs[index].likeCount)")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                            }
                        }
                        .padding(.leading,190)
                    }
                }
                Text("\(blogs[index].commentCount) Comments")
                    .foregroundColor(.black)
                    .underline()
                    .padding(.leading, 170)
            }
        }
        //this will now create another screen and it will go to the screen depending on the selectedBlogIndex which we did above, you have to call the key which is value
        .fullScreenCover(item: $selectedBlogIndex) { item in
            if (item.value == 0) {
                BlogWithComments(blogs: $blogs,index: 0)
            }
            else if (item.value == 1) {
                BlogWithComments(blogs: $blogs,index: 1)
            }
            else if (item.value == 2) {
                BlogWithComments(blogs: $blogs,index: 2)
            }
            else if (item.value == 3) {
                BlogWithComments(blogs: $blogs,index: 3)
            }
            else if (item.value == 4) {
                BlogWithComments(blogs: $blogs,index: 4)
            }
            else if (item.value == 5) {
                BlogWithComments(blogs: $blogs,index: 5)
            }
            else if (item.value == 6) {
                BlogWithComments(blogs: $blogs,index: 6)
            }
            else if (item.value == 7) {
                BlogWithComments(blogs: $blogs,index: 7)
            }
        }
    }
}
//precondition: NONE
//postcondition: this struct will control the switching between the blog video with the comments-> it is like an index
struct SelectedBlogIndex: Identifiable {
    //this is a unique identifier
    let id = UUID()
    let value: Int
}
//precondition: call the FirstBlogVideoMain(), reusing and will carry an index to determine what video it opens
//postcondition: going to allow the user to enter comments with the requirements of having name and comments
struct BlogWithComments: View {
    @Binding var blogs: [BlogItems]
    let index: Int
    
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
                        //call the function but now you pass in what index you want to get and put some padding
                        BlogVideoInformation(blogs: .constant([blogs[index]]))
                            .padding(.leading, -150)
                        
                        //look through the comments
                        ForEach(blogs[index].userComments, id: \.self) { userComment in
                            VStack {
                                Text(userComment)
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .padding(.leading, 20)
                            }
                            .padding(.top, -10)
                        }
                        
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
                                .padding(.bottom, 50)
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
                            
                            //before submitting you have to call the validate function that determines if user did input the right information
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
                            //if any one of them empty then error
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
            //you now have to increment the comment count if it passes through this if statement
            blogs[index].commentCount += 1
            //you call the userComments then you append it since it is an array-> you append the comments and it is in a string
            blogs[index].userComments.append("\(name): \(comments)")
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
                .padding(.horizontal, 10)
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
