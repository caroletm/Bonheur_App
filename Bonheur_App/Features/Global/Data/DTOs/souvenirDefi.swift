//
//  souvenirDefi.swift
//  Bonheur_App
//
//  Created by cyrilH on 31/10/2025.
//
import Foundation
struct SouvenirDefiDTO: Codable,Identifiable,Hashable {
    var id: UUID?
    var nom: String
    var photo : String?
    var theme: SouvenirTheme
    var description: String
    var planetedMission: UUID?
}

