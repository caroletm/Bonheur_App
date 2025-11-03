//
//  MissionService.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//
import Foundation
struct MissionService {
    func getAllMissions() async throws -> [MissionDTO] {
        try await APIService.shared.get("/missions")
    }
}

