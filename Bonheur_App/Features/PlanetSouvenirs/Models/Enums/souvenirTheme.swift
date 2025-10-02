//
//  souvenirTheme.swift
//  Bonheur_App
//
//  Created by caroletm on 15/09/2025.
//

import Foundation
import SwiftUI

enum SouvenirTheme: CaseIterable {
    case inspiration
    case social
    case apprentissage
    case energie
    
    var title: String {
        switch self {
        case .inspiration:
            return "Inspiration"
        case .social:
            return "Social"
        case .apprentissage:
            return "Apprentissage"
        case .energie:
            return "Energie"
        }
    }
    
    var iconName: ImageResource {
        switch self {
        case .inspiration:
            return .logoRose
        case .social:
            return .logoBleu
        case .apprentissage:
            return .logoJaune
        case .energie:
            return .logoVert
        }
    }
    
    var description: String {
        switch self {
        case .inspiration:
            return "Des instants qui éveillent ta créativité et illuminent ton quotidien."
        case .social:
            return "Les moments de partage et de lien qui nourrissent ton cœur."
        case .apprentissage:
            return "Les découvertes et réflexions qui te font grandir chaque jour."
        case .energie:
            return "Les actions qui te motivent, te dynamisent et renforcent ton équilibre."
        }
    }
    
    var color: Color {
        switch self {
        case .inspiration:
            return .pinkFluo
        case .social:
            return .blueFluo
        case .apprentissage:
            return .orangeFluo
        case .energie:
            return .greenFluo
        }
    }
}
