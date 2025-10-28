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
import AVFoundation

class AudioPlayerManager: ObservableObject {
    @Published var currentMusic: String? = nil
    @Published var isPlaying: Bool = false
    
    
    static let shared = AudioPlayerManager()
    
    private var audioPlayer: AVAudioPlayer?
    
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
        
        if let url = Bundle.main.url(forResource: name, withExtension: ext) {
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
        } else {
            print("Fichier \(filename) introuvable")
        }
    }
    
    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
        currentMusic = nil
        isPlaying = false
    }
}
