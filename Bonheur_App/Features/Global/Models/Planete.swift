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
    var route : AppRoute
    
    init(ID: UUID, nom: String, description: String, image: ImageResource, onboarding: String, iconOnboarding: ImageResource, backgroundPlanete : ImageResource, isVisited: Bool, position: CGPoint, circleSize: CGSize, circleRelativeOffset: CGPoint, route : AppRoute) {
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
        self.route = route
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
    var souvenirsData : [Souvenir] = souvenirs
}

//Instanciation de la planete souvenirs

let planeteSouvenirs = PlaneteSouvenirs(
    ID: UUID(),
    nom: "Memoria",
    description: """
    Ici, le temps se garde précieusement.
    Memoria est ton journal cosmique, l'endroit où chaque gratitude, chaque victoire et chaque acte de bonheur sont immortalisés.
    Une planète-album où tu peux revenir puiser de la force dans tes souvenirs heureux.
    """,
    image: .planeteSouvenirs2,
    onboarding: "Découvrez les souvenirs de vos voyages passés",
    iconOnboarding: .souvenirPola,
    backgroundPlanete: .backgroundSouvenirs,
    isVisited: false,
    position: CGPoint(x: 0, y: 440),
    circleSize: CGSize(width: 140, height: 140),
    circleRelativeOffset: CGPoint(x: 0, y: 0),
    route : .planeteSouvenirs
)

// MARK: - PlaneteExplora = Héritage de la classe Planete

class PlaneteExplora : Planete {
}

//Instanciation de la planete explora

let planeteExplora = PlaneteExplora(
    ID: UUID(),
    nom: "Explora",
    description: """
    Ici, tout est découverte.
    La Planète Explora t'invite à explorer ton univers, à avancer pas à pas et à trouver des trésors de bonheur semés autour de toi.
    Chaque chemin mène à une surprise, chaque arbre cache une petite lumière.
    """,
    image: .planeteExplora2,
    onboarding: "Parcours la planète et découvre les lieux qui te rendent heureux.",
    iconOnboarding: .onboardingExplora,
    backgroundPlanete: .backgroundExplora,
    isVisited: false,
    position: CGPoint(x: -100, y: 120),
    circleSize: CGSize(width: 132, height: 132),
    circleRelativeOffset: CGPoint(x: 0, y: 0),
    route : .planeteExplo
)

// MARK: - PlaneteMusic = Héritage de la classe Planete

class PlaneteMusic: Planete {
    
    var themes: [ThemeMusic]  // tableau de thèmes disponibles
    
    init(ID: UUID = UUID(),
         nom: String,
         description: String,
         image: ImageResource,
         onboarding: String,
         iconOnboarding: ImageResource,
         backgroundPlanete: ImageResource,
         isVisited: Bool = false,
         position: CGPoint,
         circleSize: CGSize,
         circleRelativeOffset: CGPoint,
         themes: [ThemeMusic]) {
        
        self.themes = themes
        
        super.init(ID: ID,
                   nom: nom,
                   description: description,
                   image: image,
                   onboarding: onboarding,
                   iconOnboarding: iconOnboarding,
                   backgroundPlanete: backgroundPlanete,
                   isVisited: isVisited,
                   position: position,
                   circleSize: circleSize,
                   circleRelativeOffset: CGPoint(x: 0, y: 0),
                   route : .planeteMusic)
    }
}


//Instanciation de la planete music
//let planeteMusic = PlaneteMusic(ID: UUID(), nom: "Music", description: "Cette planète vibre au rythme de mélodies infinies.Chaque jour, elle t’offre une musique, une ambiance ou un son qui élève ton humeur. Ici, le bonheur s’écoute, se fredonne et se partage en vibrations.", image: .planetMusic, onboarding: "Écoute, fredonne et laisse la musique élever ton humeur.", iconOnboarding: .onboardingMusic, backgroundPlanete: .backgroundMusic, isVisited: false)

let planeteMusic = PlaneteMusic(
    ID: UUID(),
    nom: "Harmonia",
    description: """
    Cette planète vibre au rythme de mélodies infinies.\n Chaque jour, elle t'offre une musique, une ambiance ou un son qui élève ton humeur.\n Ici, le bonheur s'écoute, se fredonne et se partage en vibrations.
    """,
    image: .planetemusic2,
    onboarding: "Écoute, fredonne et laisse la musique élever ton humeur.",
    iconOnboarding: .onboardingMusic,
    backgroundPlanete: .backgroundMusic,
    isVisited: false,
    position: CGPoint(x: -100, y: 300),
    circleSize: CGSize(width: 140, height: 140),
    circleRelativeOffset: CGPoint(x: 7.5, y: -6),
    themes: [
        ThemeMusic(nom: "Montagne", musique: "mountain.mp3", logo: .montagneLogo),
        ThemeMusic(nom: "Forêt", musique: "forest.mp3", logo: .foret),
        ThemeMusic(nom: "Océan", musique: "ocean.mp3", logo: .oceanLogo),
        ThemeMusic(nom: "Jungle", musique: "jungle.mp3", logo: .jungleLogo),
        ThemeMusic(nom: "FeuDeCamp", musique: "fire.mp3", logo: .feudecampLogo),
        ThemeMusic(nom: "Nuage", musique: "cloud.mp3", logo: .nuageLogo)
    ]
)


// MARK: -  PlanetePhilo = Héritage de la classe Planete

class PlanetePhilo : Planete {
}

//Instanciation de la planete philo

let planetePhilo = PlanetePhilo(
    ID: UUID(),
    nom: "Lumen",
    description: """
    Un lieu de sagesse et d'inspiration.
    Sur Lumen, les grandes philosophies du bonheur se révèlent en récits et missions. 
    Ici, tu apprends à voir le monde autrement, à cultiver des pensées qui allègent le cœur.
    """,
    image: .planetePhilo2,
    onboarding: "Découvre des pensées pour cultiver ton bonheur.",
    iconOnboarding: .onboardingPhilo,
    backgroundPlanete: .backgroundPhilo,
    isVisited: false,
    position: CGPoint(x: 100, y: 120),
    circleSize: CGSize(width: 140, height: 140),
    circleRelativeOffset: CGPoint(x: 0, y: 0),
    route : .planetePhilo
)

// MARK: -  PlaneteMissions = Héritage de la classe Planete

class PlaneteMissions : Planete {
}

//Instanciation de la planete missions

let planeteMission = PlaneteMissions (
    ID : UUID(),
    nom : "Fiestalis",
    description : """
    Sur cette planète, chaque jour est un défi joyeux
    Ici, le bonheur se construit par l'action et le jeu.
    Relève des missions quotidiennes, gagne des récompenses et partage tes victoires dans une ambiance festive et pleine d'énergie.
    """,
    image : .planeteMission2,
    onboarding : "Remémore toi les moments de bonheur que tu as passés.",
    iconOnboarding : .onboardingMissions,
    backgroundPlanete: .backgroundMissions,
    isVisited : false,
    position: CGPoint(x: 120, y: 300),
    circleSize: CGSize(width: 130, height: 130),
    circleRelativeOffset: CGPoint(x: -2, y: 0),
    route : .planeteMission
)
