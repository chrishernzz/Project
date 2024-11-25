//
//  VideoWelcoming.swift
//  Project
//
//  Created by Christian Hernandez on 11/19/24.
//

import SwiftUI
import AVKit

struct VideoWelcoming: View {
    //closure function
    var onVideoEnd: () -> Void
    var body: some View {
        ZStack {
            //this is the RGB for background
            Color(red: 1.0, green: 0.8, blue: 0.9)
                .edgesIgnoringSafeArea(.all)
            if let videoURL = Bundle.main.url(forResource: "Untitled design", withExtension: "mp4") {
                FullScreenVideoPlayer(videoURL: videoURL, onVideoEnd: onVideoEnd)
                    .edgesIgnoringSafeArea(.all)
            } 
            else {
                Text("Video not found")
                    .foregroundColor(.red)
            }
        }
    }
}

struct FullScreenVideoPlayer: UIViewControllerRepresentable {
    //two arguments which is the url and closure function
    var videoURL: URL
    var onVideoEnd: () -> Void
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let player = AVPlayer(url: videoURL)

        //creates the AVPPlayer
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = UIScreen.main.bounds
        viewController.view.layer.addSublayer(playerLayer)

        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            onVideoEnd()
        }
        player.play()

        return viewController
    }
    //using the UIViewController
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}


