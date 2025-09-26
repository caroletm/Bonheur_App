//
//  Planete.swift
//  Bonheur_App
//
//  Created by caroletm on 26/09/2025.
//

import Foundation
import SwiftUI

class Planete: Hashable, Identifiable  {
    var ID : UUID
    var nom : String
    var description : String
    var image : ImageResource
    var onboarding : String
    var iconOnboarding : ImageResource
    var isVisited : Bool
    
    init(ID: UUID, nom: String, description: String, image: ImageResource, onboarding: String, iconOnboarding: ImageResource, isVisited: Bool) {
        self.ID = ID
        self.nom = nom
        self.description = description
        self.image = image
        self.onboarding = onboarding
        self.iconOnboarding = iconOnboarding
        self.isVisited = isVisited
    }
    
    // MARK: - Hashable
    static func == (lhs: Planete, rhs: Planete) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - : PlaneteSouvenirs = Héritage de la classe Planete

class PlaneteSouvenirs : Planete {
    var souvenirsData : [any Souvenir] = souvenirs
}

//Instanciation de la planete souvenirs
let planeteSouvenirs = PlaneteSouvenirs(ID: UUID(), nom: "Souvenirs", description: "Explorez les souvenirs de votre voyage", image: .planetSouvenirs, onboarding: "Découvrez les souvenirs de vos voyages passés", iconOnboarding: .souvenirPola, isVisited: false)

// MARK: - PlaneteExplora = Héritage de la classe Planete

class PlaneteExplora : Planete {
}

//Instanciation de la planete explora
let planeteExplora = PlaneteExplora(ID: UUID(), nom: "Explora", description: "Explorez le monde", image: .planetExplora, onboarding: "Découvrez le monde et ses aventures", iconOnboarding: .onboardingExplora, isVisited: false)

// MARK: - PlaneteMusic = Héritage de la classe Planete

class PlaneteMusic : Planete {
}

//Instanciation de la planete music
let planeteMusic = PlaneteMusic(ID: UUID(), nom: "Music", description: "Écoutez de la musique", image: .planetMusic, onboarding: "Écoutez de la musique et découvrez de nouveaux artistes", iconOnboarding: .onboardingMusic, isVisited: false)


// MARK: -  PlanetePhilo = Héritage de la classe Planete

class PlanetePhilo : Planete {
}

//Instanciation de la planete philo
let planetePhilo = PlanetePhilo(ID: UUID(), nom: "Philo", description: "Profitez des philosophes", image: .planetPhilosophie, onboarding: "Profitez des philosophes et découvrez leurs pensées", iconOnboarding: .onboardingPhilo, isVisited: false)


// MARK: -  PlaneteMissions = Héritage de la classe Planete

class PlaneteMissions : Planete {
}

//Instanciation de la planete missions
let planeteMission = PlaneteMissions (ID : UUID(), nom : "Mission", description : "Explorez la mission de l'app", image : .planetMissions, onboarding : "Découvrez la mission de l'application", iconOnboarding : .onboardingMissions, isVisited : false)


