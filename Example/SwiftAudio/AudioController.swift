//
//  AudioController.swift
//  SwiftAudio_Example
//
//  Created by Jørgen Henrichsen on 25/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SwiftAudioEx


class AudioController {
    
    static let shared = AudioController()
    let player: QueuedAudioPlayer
    let audioSessionController = AudioSessionController.shared
    
    let sources: [AudioItem] = [
        DefaultAudioItem(audioUrl: "https://kexp-mp3-128.streamguys1.com/kexp128.mp3", artist: "KEXP", title: "KEXP", sourceType: .stream, artwork: #imageLiteral(resourceName: "22AMI")),
        DefaultAudioItem(audioUrl: "https://live.welle1.at:17128/stream", artist: "WERU", title: "WERU", sourceType: .stream, artwork: #imageLiteral(resourceName: "22AMI")),
        DefaultAudioItem(audioUrl: "https://stream.pacificaservice.org:9000/weru_128", artist: "David Chavez", title: "Soul Searching (Demo)", sourceType: .stream, artwork: #imageLiteral(resourceName: "22AMI")),

    ]
    
    init() {
        let controller = RemoteCommandController()
        player = QueuedAudioPlayer(remoteCommandController: controller)
        player.remoteCommands = [
            .stop,
            .play,
            .pause,
            .togglePlayPause,
            .next,
            .previous,
            .changePlaybackPosition
        ]
        try? audioSessionController.set(category: .playback)
        player.repeatMode = .queue
        DispatchQueue.main.async {
            self.player.add(items: self.sources)
        }
    }
    
}
