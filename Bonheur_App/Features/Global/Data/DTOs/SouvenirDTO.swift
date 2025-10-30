//
//  SouvenirDTO.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//

import Foundation

struct SouvenirDTO: Codable, Hashable {
    var id: UUID?
    var nom: String
    var photo: String?
    var description: String
    var theme: SouvenirTheme
    var type: SouvenirType
    var date: Date
    var latitude: Double?
    var longitude: Double?
    var isValidated: Bool?
}
