//
//  MainBlogPage.swift
//  Project
//
//  Created by Christian Hernandez on 12/4/24.
//

import SwiftUI

struct MainBlogPage: View {
    //create an array of BlogItems (the struct)
    @State private var blogitems = [
        BlogItems(title: "Vlog: Darts on Board Final Project (Dart Manipulation on Front Bodice)",date:"11/30/2024",comments: 0, video: URL(string: "https://www.youtube.com/embed/Qbq01KvOFz0")!, description:"Come along as I work on my second final project for my pattern making and design 1 class. We had to manipulate the dart on the front bodice 9 times and create a 3D model of them and display them on a board and this is how mine turned out! Did I create more work for myself by retracing and creating an embroidery file out of them? Yes, I did haha but it was fun creating my own textiles with my embroidery machine that it gave me some ideas for future designs/projects!", likeCount: 0, commentCount: 0, userComments: []),
        BlogItems(title: "Vlog: Final Project for Pattern making Class - Drafting & Sewing Sample",date:"11/25/2024",comments: 0, video: URL(string: "https://www.youtube.com/embed/5bhcQbpiHOw")!, description:"Let's continue working on my final project! Now that I have my basic blocks in kids 3T, I can finally start making changes to create the dress I sketched out. After sewing the sample I decided to make a quick design change on the peplum. I'm going to use the circle skirt and shorten it to create a 2nd layer instead. I think the first peplum didn't have the volume/flare I wanted it to have. I would fix the issue if I had more time but we only have one more class left before we need to present the project so for now we are just changing the design. What's left to do is to quickly touch up the pattern and make sure everything is labeled correctly and then I can start cutting the pattern on the nicer fabric! So let go fabric shopping!", likeCount: 0, commentCount: 0,userComments: []),
        BlogItems(title: "How to Access & Download Digital Files from our Shop",date:"11/8/2024",comments: 0, video: URL(string: "https://www.youtube.com/embed/pkDgBO9PA-U")!, description:"Creating a FAQ'S Playlist for our shop and in this video, I quickly show you how to login and download digital files from our shop once order is placed!",likeCount: 0, commentCount: 0, userComments: []),
        BlogItems(title: "Vlog: Final Project for Pattern making Class - Making Basic Block",date:"11/7/2024",comments: 0, video: URL(string: "https://www.youtube.com/embed/uGgNutgTEUs")!, description:"​I'm currently taking Pattern making and design Level 1 this fall semester and I have three main final projects for this class so I thought I would bring you along as I work on them. The first project is creating a garment based on what we learned this semester. Most of the basic blocks we've been making have been in women's sizing but I did ask my professor if it was possible to make it in kids instead so I have to recreate what we've been doing in class into a kids 3T and here's how everything turned out!", likeCount: 0, commentCount: 0, userComments: []),
        BlogItems(title: "Step by step Appliqué Boo Ghost Sweater",date:"10/31/2024",comments: 0, video: URL(string: "https://www.youtube.com/embed/KzTBPFUhzuM")!, description:"​This sweater turned out so cute! Don't forget to heatpress if you end up using the glitter iron on vinyl! File: https://yeseniadesignsshop.com/listing/1804505266/dst-embroidery-applique-file-boo-mouse", likeCount: 0, commentCount: 0, userComments: []),
        BlogItems(title: "What’s in my school bag (Fashion student ed.)",date:"10/27/2024",comments: 0, video: URL(string: "https://www.youtube.com/embed/7cNa__ETLdk")!, description:"""
        I thought I would do a what’s in my school bag video and show you how I organize and carry all of my sewing/pattern making tools to class!
                  
                  *ROLLING CART
                  https://amzn.to/4hkm3xf

                  *PINK BINDER
                  https://amzn.to/3YuCZJ0

                  *PINK STORAGE BIN UNIT
                   https://amzn.to/48lG6aB
        """, likeCount: 0, commentCount: 0, userComments: []),
        BlogItems(title: "Kids (Youth Sizing) Dinosaur Poncho Sewing Pattern Step by Step Tutorial",date:"9/17/2024",comments: 0, video: URL(string: "https://www.youtube.com/embed/SDmT86CEWPo")!, description:"""
        Our dinosaur poncho is now available in youth sizes M-XL
                  https://yeseniadesignsshop.com/listing/1775473838/pdf-dinosaur-poncho-sewing-pattern-kids
        """, likeCount: 0, commentCount: 0, userComments: [])
    ]
    
    var body: some View {
        ZStack {
            //even if dark mode we want background to be white
            Color.white.edgesIgnoringSafeArea(.all)
            //Call the main first blog here
            BlogVideoInformation(blogs: $blogitems)
        }
    }
}
//precondition: requires a unique identifier for each instance, which allows to distinguish one item from another-> using Identifiable and needs an ID(key->value).
//postcondition: this struct takes in all the information of the blog that concludes the title, date, comment, video, and description
struct BlogItems: Identifiable {
    var id: String { title }
    var title: String
    var date: String
    var comments: Int
    var video: URL
    var description: String
    var likeCount: Int
    var commentCount: Int
    var userComments: [String]
}
