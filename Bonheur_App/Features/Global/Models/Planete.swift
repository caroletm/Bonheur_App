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
    var backgroundPlanete : ImageResource
    var isVisited : Bool
    var position: CGPoint
    var circleSize: CGSize
    var circleRelativeOffset: CGPoint
    
    init(ID: UUID, nom: String, description: String, image: ImageResource, onboarding: String, iconOnboarding: ImageResource, backgroundPlanete : ImageResource, isVisited: Bool, position: CGPoint, circleSize: CGSize, circleRelativeOffset: CGPoint) {
        self.ID = ID
        self.nom = nom
        self.description = description
        self.image = image
        self.onboarding = onboarding
        self.iconOnboarding = iconOnboarding
        self.backgroundPlanete = backgroundPlanete
        self.isVisited = isVisited
        self.position = position
        self.circleSize = circleSize
        self.circleRelativeOffset = circleRelativeOffset
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
let planeteSouvenirs = Planete(
    ID: UUID(),
    nom: "Souvenirs",
    description: "Ici, le temps se garde précieusement. Memoria est ton journal cosmique, l’endroit où chaque gratitude, chaque victoire et chaque acte de bonheur sont immortalisés. Une planète-album où tu peux revenir puiser de la force dans tes souvenirs heureux.",
    image: .planetSouvenirs,
    onboarding: "Découvrez les souvenirs de vos voyages passés",
    iconOnboarding: .souvenirPola,
    backgroundPlanete: .backgroundSouvenirs,
    isVisited: false,
    position: CGPoint(x: 0, y: 440),
    circleSize: CGSize(width: 140, height: 140),
    circleRelativeOffset: CGPoint(x: 8, y: -5)
)

// MARK: - PlaneteExplora = Héritage de la classe Planete

class PlaneteExplora : Planete {
}

//Instanciation de la planete explora
let planeteExplora = Planete(
    ID: UUID(),
    nom: "Explora",
    description: "Ici, tout est découverte. La Planète Explora t’invite à explorer ton univers, à avancer pas à pas et à trouver des trésors de bonheur semés autour de toi. Chaque chemin mène à une surprise, chaque arbre cache une petite lumière.",
    image: .planetExplora,
    onboarding: "Parcours la planète et découvre les lieux qui te rendent heureux.",
    iconOnboarding: .onboardingExplora,
    backgroundPlanete: .backgroundExplora,
    isVisited: false,
    position: CGPoint(x: -100, y: 120),
    circleSize: CGSize(width: 138, height: 138),
    circleRelativeOffset: CGPoint(x: 7, y: -5)
)

// MARK: - PlaneteMusic = Héritage de la classe Planete

class PlaneteMusic : Planete {
}

//Instanciation de la planete music
let planeteMusic = Planete(
    ID: UUID(),
    nom: "Music",
    description: "Cette planète vibre au rythme de mélodies infinies. Chaque jour, elle t’offre une musique, une ambiance ou un son qui élève ton humeur. Ici, le bonheur s’écoute, se fredonne et se partage en vibrations.",
    image: .planetMusic,
    onboarding: "Écoute, fredonne et laisse la musique élever ton humeur.",
    iconOnboarding: .onboardingMusic,
    backgroundPlanete: .backgroundMusic,
    isVisited: false,
    position: CGPoint(x: -100, y: 300),
    circleSize: CGSize(width: 140, height: 140),
    circleRelativeOffset: CGPoint(x: 7.5, y: -6)
)

// MARK: -  PlanetePhilo = Héritage de la classe Planete

class PlanetePhilo : Planete {
}

//Instanciation de la planete philo
let planetePhilo = Planete(
    ID: UUID(),
    nom: "Philo",
    description: "Un lieu de sagesse et d’inspiration. Sur Lumen, les grandes philosophies du bonheur se révèlent en récits et missions. Ici, tu apprends à voir le monde autrement, à cultiver des pensées qui allègent le cœur.",
    image: .planetPhilosophie,
    onboarding: "Profitez des philosophes et découvrez leurs pensées",
    iconOnboarding: .onboardingPhilo,
    backgroundPlanete: .backgroundPhilo,
    isVisited: false,
    position: CGPoint(x: 100, y: 120),
    circleSize: CGSize(width: 129, height: 129),
    circleRelativeOffset: CGPoint(x: 4, y: 2)
)

// MARK: -  PlaneteMissions = Héritage de la classe Planete

class PlaneteMissions : Planete {
}

//Instanciation de la planete missions
let planeteMissions = Planete(
    ID: UUID(),
    nom: "Missions",
    description: "Sur cette planète, chaque jour est un défi joyeux ! Ici, le bonheur se construit par l’action et le jeu. Relève des missions quotidiennes, gagne des récompenses et partage tes victoires dans une ambiance festive et pleine d’énergie.",
    image: .planetMissions,
    onboarding: "Découvrez la mission de l'application",
    iconOnboarding: .onboardingMissions,
    backgroundPlanete: .backgroundMissions,
    isVisited: false,
    position: CGPoint(x: 120, y: 300),
    circleSize: CGSize(width: 130, height: 130),
    circleRelativeOffset: CGPoint(x: 7, y: 2)
)
