//
//  AppRoute.swift
//  Bonheur_App
//
//  Created by caroletm on 26/09/2025.
//

import Foundation

enum AppRoute: Hashable {
    
    case pageCitation
    case planeteUserTest
    case landing(planete : Planete)
    case onboarding(planete : Planete)
    case planeteSouvenirs
    case souvenirsFiltre
    case planeteExplo
    case planeteMusic
    case planetePhilo
    case planeteMission
<<<<<<< HEAD
    case missionAccepter(challenge: Challenge)
=======
    case detailSouvenir (souvenir : Souvenir)
>>>>>>> 628b9014aa2ad9b7cbe7c760bbfbe0c22bd49ffb
    
}
