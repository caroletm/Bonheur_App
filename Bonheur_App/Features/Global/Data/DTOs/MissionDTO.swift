//
//  MissionDTO.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//
import Foundation

struct MissionDTO: Codable,Identifiable,Hashable {
    var id: UUID?
    var nom: String
//    var planeteMissionId: UUID?
}

