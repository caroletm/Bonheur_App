
import SwiftUI
import AVFoundation

@MainActor
final class MusicPlayerViewModel: ObservableObject {
    @Published var selectedSegment: Int? = 0
    @Published var isPlaying: Bool = false
    
    let planeteMusic: PlaneteMusic
    private let audioManager = AudioPlayerManager.shared
    
    init(planeteMusic: PlaneteMusic) {
        self.planeteMusic = planeteMusic
        
        audioManager.$isPlaying
            .receive(on: DispatchQueue.main)
            .assign(to: &$isPlaying)
        
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
            if isPlaying {
                stopMusic()
            } else {
                playMusic(theme)
            }
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
