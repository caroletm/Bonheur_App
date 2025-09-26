//
//  PlanetViewModel.swift
//  Bonheur_App
//
//  Created by caroletm on 26/09/2025.
//

import SwiftUI
import Foundation
import Observation

@Observable

class PlanetViewModel {
    
    //MARK: - Data
    
    let planetes : [Planete] = [planeteSouvenirs, planeteExplora, planeteMusic, planetePhilo, planeteMission]

}
