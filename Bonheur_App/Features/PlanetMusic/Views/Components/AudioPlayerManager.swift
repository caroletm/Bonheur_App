//
//  AudioPlayerManager.swift
//  Bonheur_App
//
//  Singleton responsable de la lecture audio via AVAudioPlayer.
//  Created by Apprenant156 on 01/10/2025.
//

import SwiftUI
import Foundation
import AVFoundation

@Observable
final class AudioPlayerManager {
    static let shared = AudioPlayerManager() // Singleton global

    private var audioPlayer: AVAudioPlayer?   // Instance du lecteur audio

    // État courant
    var currentMusic: String? = nil
    var isPlaying: Bool = false {
        didSet { onPlayStateChanged?(isPlaying) }
    }

    // Callback permettant au ViewModel d’être notifié des changements
    var onPlayStateChanged: ((Bool) -> Void)?

    // MARK: - Lecture d’un fichier audio
    func play(_ filename: String) {
        stop() // Stoppe toute lecture précédente

        var name = filename
        var ext: String? = nil

        // Extraction du nom et de l’extension
        if filename.contains(".") {
            let parts = filename.split(separator: ".")
            name = String(parts.first ?? "")
            ext = String(parts.last ?? "")
        } else {
            ext = "mp3"
        }

        // Chargement du fichier audio
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            print("Fichier \(filename) introuvable")
            return
        }

        // Initialisation du player
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Lecture en boucle infinie
            audioPlayer?.play()

            currentMusic = filename
            isPlaying = true
            print("Lecture : \(filename)")
        } catch {
            print("Erreur lecture \(filename): \(error.localizedDescription)")
        }
    }

    // MARK: - Arrêt de la lecture
    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
        currentMusic = nil
        isPlaying = false
    }
}
