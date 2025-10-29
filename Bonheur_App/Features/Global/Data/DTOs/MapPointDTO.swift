//
//  MapPointDTO.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//

import Foundation

struct MapPointDTO: Codable, Identifiable, Hashable {
    var id: UUID?
    var nom: String
    var photo : String?
    var theme: SouvenirTheme
    var description: String
    var latitude: Double
    var longitude: Double
    var planeteExploId: UUID?
}

struct UpdateMapPointDTO: Codable {
    var nom: String?
    var photo : String?
    var theme: SouvenirTheme?
    var description: String?
    var latitude: Double?
    var longitude: Double?
}
