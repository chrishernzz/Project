//
//  VideoWelcoming.swift
//  Project
//
//  Created by Christian Hernandez on 11/19/24.
//

import SwiftUI
import AVKit

struct VideoWelcoming: View {
    var onVideoEnd: () -> Void

    var body: some View {
        ZStack {
            // Fallback background matching the video
            Color(red: 1.0, green: 0.8, blue: 0.9) // Replace with the exact RGB of the video
                .edgesIgnoringSafeArea(.all)

            if let videoURL = Bundle.main.url(forResource: "videointroforapp", withExtension: "mp4") {
                FullScreenVideoPlayer(videoURL: videoURL, onVideoEnd: onVideoEnd)
                    .edgesIgnoringSafeArea(.all) // Ensure the video fills the screen
            } else {
                Text("Video not found")
                    .foregroundColor(.red)
            }
        }
    }
}

struct FullScreenVideoPlayer: UIViewControllerRepresentable {
    var videoURL: URL
    var onVideoEnd: () -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let player = AVPlayer(url: videoURL)

        // Create the AVPlayerLayer
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill // Ensures video fills the screen
        playerLayer.frame = UIScreen.main.bounds
        viewController.view.layer.addSublayer(playerLayer)

        // Observer for video end
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            onVideoEnd()
        }

        // Start playback
        player.play()

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}


