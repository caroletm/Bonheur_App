//
//  MissionViewModel.swift
//  Bonheur_App
//
//  Created by cyrilH on 30/09/2025.
//

import Foundation
@Observable
// MARK: - ViewModel des défis quotidiens
/// `ChallengeViewModel` gère la récupération et la sélection des missions quotidiennes.
/// Il permet :
/// - de charger la liste complète des missions depuis l’API,
/// - d’afficher la mission du jour,
/// - de basculer vers une mission aléatoire,
/// - et de gérer l’état courant de l’affichage.
class ChallengeViewModel{
    
    // MARK: - Propriétés principales
    /// Liste complète des missions récupérées depuis le service.
    var challenges: [MissionDTO] = []
    /// Index de la mission actuellement affichée.
    var currentIndex : Int = 0
    /// Index de la mission du jour (défi principal).
    var dayChallengeIndex : Int = 0
    /// Index d'une mission aléatoire secondaire.
    var randomChallengeIndex : Int = 0
    
    /// Service responsable de la récupération des missions.
    private let service = MissionService()
    
    
    
    // MARK: - Initialisation
    /// Initialise le ViewModel et tente de charger les missions depuis le backend.
    
    init() {
        Task {
            await fetchMission()
        }
    }
    
    // MARK: - Mission courante
    ///  Retourne la mission actuellement sélectionnée.
    var currentMision: MissionDTO? {
        guard !challenges.isEmpty else { return nil }
        return challenges[currentIndex]
    }
    
    // MARK: - Vérification mission du jour
    /// Indique si la mission actuellement affichée est la mission du jour.
    var isDayChallenge : Bool {
        currentIndex == dayChallengeIndex
    }
    
    // MARK: - Texte du bouton d’alternance
    /// Texte dynamique pour le bouton permettant de basculer entre les missions.
    var toggleButtonTitle: String {
        isDayChallenge ? "Donner une autre mission" : "Retour à la mission du jour"
    }
    
    // MARK: - Alternance entre mission du jour et mission aléatoire
    /// Bascule entre la mission du jour et une mission aléatoire.
    func toggleChallenge() {
        guard !challenges.isEmpty else { return }
        currentIndex = isDayChallenge ? randomChallengeIndex : dayChallengeIndex
    }
    
    // MARK: - Chargement des missions
    /// Récupère toutes les missions depuis le service distant.
    /// Définit une mission du jour et une mission aléatoire.
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
}
