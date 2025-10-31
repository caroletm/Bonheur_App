
import SwiftUI
import AVFoundation

@Observable
final class MusicPlayerViewModel {
    var selectedSegment: Int? = 0
    var isPlaying: Bool = false

    let planeteMusic: PlaneteMusic
    private let audioManager: AudioPlayerManager

    init(planeteMusic: PlaneteMusic, audioManager: AudioPlayerManager = .shared) {
        self.planeteMusic = planeteMusic
        self.audioManager = audioManager

        // Synchronise automatiquement l’état du player
        audioManager.onPlayStateChanged = { [weak self] isPlaying in
            self?.isPlaying = isPlaying
        }

        if let current = audioManager.currentMusic {
            if let index = planeteMusic.themes.firstIndex(where: { $0.musique == current }) {
                selectedSegment = index
                isPlaying = true
            }
        }
    }

    func handleSegmentTap(index: Int) {
        let theme = planeteMusic.themes[index]

        if selectedSegment == index {
            isPlaying ? stopMusic() : playMusic(theme)
        } else {
            selectedSegment = index
            playMusic(theme)
        }
    }

    func togglePlayPause() {
        if isPlaying {
            stopMusic()
        } else {
            guard let index = selectedSegment else {
                selectedSegment = 0
                playMusic(planeteMusic.themes[0])
                return
            }
            playMusic(planeteMusic.themes[index])
        }
    }

    private func playMusic(_ theme: ThemeMusic) {
        isPlaying = true
        audioManager.play(theme.musique)
    }

    private func stopMusic() {
        isPlaying = false
        audioManager.stop()
    }
}
