//
//  AudioPlayerManager.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 01/10/2025.
//
import SwiftUI
import AVFoundation

class AudioPlayerManager: ObservableObject {
    // ✅ Singleton accessible partout
    static let shared = AudioPlayerManager()
    
    private var audioPlayer: AVAudioPlayer?

    func play(_ filename: String) {
        stop() // arrête ce qui jouait avant

        var name = filename
        var ext: String? = nil

        // Permet d’accepter "mountain.mp3" ou juste "mountain"
        if filename.contains(".") {
            let parts = filename.split(separator: ".")
            name = String(parts.first ?? "")
            ext = String(parts.last ?? "")
        } else {
            ext = "mp3"
        }

        if let url = Bundle.main.url(forResource: name, withExtension: ext) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1 // boucle infinie
                audioPlayer?.play()
                print("▶️ Lecture : \(filename)")
            } catch {
                print("❌ Erreur lecture \(filename): \(error.localizedDescription)")
            }
        } else {
            print("❌ Fichier \(filename) introuvable dans le bundle")
        }
    }

    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}

