//
//  MissionViewModel.swift
//  Bonheur_App
//
//  Created by cyrilH on 30/09/2025.
//

import Foundation
@Observable
    /// `ChallengeViewModel` est une classe observable utilisée pour gérer une liste de défis quotidiens.
    /// Elle fournit la logique nécessaire pour afficher le défi du jour, naviguer entre les défis,
    /// et suivre l’état actuel de la progression.
class ChallengeViewModel{
    // MARK: - Propriétés
    var challenges: [MissionDTO] = []
    var currentIndex : Int = 0
    var dayChallengeIndex : Int = 0
    var randomChallengeIndex : Int = 0
    
    private let service = MissionService()
    
    
    
    // MARK: - Initialisation
    /// Initialise le `ViewModel` et sélectionne le défi du jour s’il existe.
    /// Sinon, sélectionne le premier défi de la liste.
    
    init() {
        Task {
            await fetchMission()
        }
    }
    var currentMision: MissionDTO? {
        guard !challenges.isEmpty else { return nil }
        return challenges[currentIndex]
    }
    var isDayChallenge : Bool {
        currentIndex == dayChallengeIndex
    }
    var toggleButtonTitle: String {
        isDayChallenge ? "Donner une autre mission" : "Retour à la mission du jour"
    }
    
    func toggleChallenge() {
        guard !challenges.isEmpty else { return }
        currentIndex = isDayChallenge ? randomChallengeIndex : dayChallengeIndex
    }
    
    func fetchMission() async {
        do {
            let missionsFromAPI = try await service.getAllMissions()
            challenges = missionsFromAPI
            dayChallengeIndex = Int.random(in: 0..<challenges.count)
            repeat {
                randomChallengeIndex = Int.random(in: 0..<challenges.count)
            } while randomChallengeIndex == dayChallengeIndex
                        currentIndex = dayChallengeIndex
        } catch {
            print("Erreur lors de la recuperation :\(error)")
        }
    }
    

        
//        let dayIndex = Int.random(in: 0..<list.count)
//        
//        self.dayChallengeIndex = dayIndex
//        
//        var randomIndex: Int
//        repeat {
//            randomIndex = Int.random(in: 0..<list.count)
//        } while randomIndex == dayIndex
//        self.randomChallengeIndex = randomIndex
//        self.currentIndex = dayIndex
//    }
    
//    var currentChallenge: Challenge {
//        challenges[currentIndex]
//    }
//    var isDayChallenge: Bool {
//        currentIndex == dayChallengeIndex
//    }
//    
//    
    
}
