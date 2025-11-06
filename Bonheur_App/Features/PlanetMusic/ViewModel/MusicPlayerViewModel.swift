//
//  MusicPlayerViewModel.swift
//  Bonheur_App
//
//  Gère la logique de lecture musicale : sélection, lecture/pause et synchronisation avec le player audio.
//  Created by Apprenant156 on 11/09/2025.
//

import SwiftUI
import AVFoundation

@Observable
final class MusicPlayerViewModel {
    // MARK: - Propriétés d’état
    var selectedSegment: Int? = nil   // Index du thème musical sélectionné
    var isPlaying: Bool = false       // Indique si une musique est en cours

    // MARK: - Dépendances
    let planeteMusic: PlaneteMusic    // Contient la liste des thèmes musicaux pour la planète
    private let audioManager: AudioPlayerManager // Gère la lecture audio

    // MARK: - Initialisation
    init(planeteMusic: PlaneteMusic, audioManager: AudioPlayerManager = .shared) {
        self.planeteMusic = planeteMusic
        self.audioManager = audioManager

        // Synchronise automatiquement l’état du ViewModel avec celui de l’audioManager
        audioManager.onPlayStateChanged = { [weak self] isPlaying in
            self?.isPlaying = isPlaying
        }

        // Si une musique est déjà en cours, on retrouve son index dans la liste
        if let current = audioManager.currentMusic,
           let index = planeteMusic.themes.firstIndex(where: { $0.musique == current }) {
            selectedSegment = index
            isPlaying = true
        }
    }

    // MARK: - Gestion des interactions utilisateur

    // Gère le tap sur un segment (thème musical)
    func handleSegmentTap(index: Int) {
        let theme = planeteMusic.themes[index]

        if selectedSegment == index {
            // Si on reclique sur le même segment → lecture/pause
            isPlaying ? stopMusic() : playMusic(theme)
        } else {
            // Sinon on change de thème
            selectedSegment = index
            playMusic(theme)
        }
    }

    // Bascule entre lecture et pause depuis le bouton central
    func togglePlayPause() {
        if isPlaying {
            stopMusic()
        } else {
            guard let index = selectedSegment else {
                // Si aucun segment sélectionné → joue le premier par défaut
                selectedSegment = 0
                playMusic(planeteMusic.themes[0])
                return
            }
            playMusic(planeteMusic.themes[index])
        }
    }

    // MARK: - Gestion interne du player
    private func playMusic(_ theme: ThemeMusic) {
        isPlaying = true
        audioManager.play(theme.musique)
    }

    private func stopMusic() {
        isPlaying = false
        audioManager.stop()
    }
}
