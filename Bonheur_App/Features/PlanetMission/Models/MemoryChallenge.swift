//
//  memoryChallenge.swift
//  Bonheur_App
//
//  Created by cyrilH on 01/10/2025.
//

import Foundation
import SwiftUI

struct MemoryChallenge :  Identifiable {
    var id : UUID = UUID()
    var nameMemory : String
    var descriptionMemory : String
    var imageMemory : String?
    var themeMemory : ThemeType
    var creationDate : Date = Date()
}

enum ThemeType: String, CaseIterable{
    case inspiration = "Inspiration"
    case social = "Social"
    case apprentissage = "Apprentissage"
    case energie = "Energie"
    
    var iconName: String {
            switch self {
            case .inspiration: return "logoRose"
            case .social: return "logoBleu"
            case .apprentissage: return "logoJaune"
            case .energie: return "logoVert"
            }
        }
}
