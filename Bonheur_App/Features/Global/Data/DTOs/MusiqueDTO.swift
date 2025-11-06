//
//  MusiqueDTO.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//

import Foundation

struct MusicDTO: Codable {
    var id: UUID?
    var nom: String
    var audio: String
    var logo: String
    var planeteMusicId: UUID?
}
