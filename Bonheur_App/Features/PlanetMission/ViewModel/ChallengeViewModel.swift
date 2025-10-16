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
    var challenges: [Challenge]
    var currentIndex : Int
    var dayChallengeIndex : Int
    var randomChallengeIndex : Int
    
    // MARK: - Initialisation
    
    /// Initialise le `ViewModel` et sélectionne le défi du jour s’il existe.
    /// Sinon, sélectionne le premier défi de la liste.
    init(challenges: [Challenge]? = nil) {
        
        let list = challenges ?? [
            Challenge(challengeName: "Promène-toi dans un parc à l'ombre"),
            Challenge(challengeName: "Bois deux litres d’eau"),
            Challenge(challengeName: "Fais 10 pompes"),
            Challenge(challengeName: "Lis 10 pages"),
            Challenge(challengeName: "Marche 5000 pas")
        ]
        self.challenges = list

        
        let dayIndex = Int.random(in: 0..<list.count)
        
        self.dayChallengeIndex = dayIndex
        
        var randomIndex: Int
        repeat {
            randomIndex = Int.random(in: 0..<list.count)
        } while randomIndex == dayIndex
        self.randomChallengeIndex = randomIndex
        self.currentIndex = dayIndex
    }
    // MARK: - Accès au défi courant
    
    /// Retourne le défi actuellement sélectionné.
    /// - Returns: Le `Challenge` correspondant à `currentIndex`, ou `nil` si aucun n’est défini.
    var currentChallenge: Challenge {
        challenges[currentIndex]
    }
    var isDayChallenge: Bool {
        currentIndex == dayChallengeIndex
    }
    var toggleButtonTitle: String {
        isDayChallenge ? "Donner une autre mission" : "Retour à la mission du jour"
    }
    
    func toggleChallenge() {
        currentIndex = isDayChallenge ? randomChallengeIndex : dayChallengeIndex
        
    }
}
