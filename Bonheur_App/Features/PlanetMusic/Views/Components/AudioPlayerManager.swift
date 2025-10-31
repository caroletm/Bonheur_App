//
//  AudioPlayerManager.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 01/10/2025.
//
//
//  AudioPlayerManager.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 01/10/2025.
//
import SwiftUI
import Foundation
import AVFoundation

@Observable
final class AudioPlayerManager {
    static let shared = AudioPlayerManager()

    private var audioPlayer: AVAudioPlayer?

    var currentMusic: String? = nil
    var isPlaying: Bool = false {
        didSet {
            onPlayStateChanged?(isPlaying)
        }
    }

    // Callback pour notifier le ViewModel
    var onPlayStateChanged: ((Bool) -> Void)?

    func play(_ filename: String) {
        stop()

        var name = filename
        var ext: String? = nil

        if filename.contains(".") {
            let parts = filename.split(separator: ".")
            name = String(parts.first ?? "")
            ext = String(parts.last ?? "")
        } else {
            ext = "mp3"
        }

        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            print("Fichier \(filename) introuvable")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()

            currentMusic = filename
            isPlaying = true

            print("Lecture : \(filename)")
        } catch {
            print("Erreur lecture \(filename): \(error.localizedDescription)")
        }
    }

    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
        currentMusic = nil
        isPlaying = false
    }
}
