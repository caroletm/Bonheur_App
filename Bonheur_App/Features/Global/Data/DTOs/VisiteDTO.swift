//
//  VisiteDTO.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//
import Foundation


struct VisiteDTO: Codable, Identifiable {
    var id: UUID?
    var dateTime: Date?
    var userId: UUID
    var planeteId: UUID
}

struct VisiteCreateDTO: Codable {
    var planeteId: UUID
}

