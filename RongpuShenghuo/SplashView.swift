//
//  SplashScreen.swift
//  RongpuShenghuo
//
//  Created by Ziming Qiu on 1/14/25.
//

import SwiftUI
import AVKit

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            RootView()
        } else {
            LaunchVideoPlayerView(videoName: "LaunchVideo")
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        isActive = true
                    }
                }
                .ignoresSafeArea() // Ensures the video covers the entire screen
        }
    }
}

struct LaunchVideoPlayerView: View {
    let videoName: String

    var body: some View {
        let player = AVPlayer(url: Bundle.main.url(forResource: videoName, withExtension: "mp4")!)
        ZStack {
            Color.white // Set the background color to white
                            .ignoresSafeArea()
            VideoPlayer(player: player)
                .onAppear {
                    player.play()
                }
                .aspectRatio(contentMode: .fit)
        }
    }
}
#Preview {
    SplashView()
}
