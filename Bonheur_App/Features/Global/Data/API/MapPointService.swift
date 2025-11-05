//
//  MapPointService.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//

import Foundation

struct MapPointService {
    func getAllMapPoints() async throws -> [MapPointDTO] {
        try await APIService.shared.get("/mapPoints")
    }

    func getMapPointById(_ id: UUID) async throws -> MapPointDTO {
        try await APIService.shared.get("/mapPoints/\(id)")
    }

    func createMapPoint(_ dto: MapPointDTO) async throws -> MapPointDTO {
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            print("Aucun token trouvé dans UserDefaults")
            throw URLError(.userAuthenticationRequired)
        }
        return try await APIService.shared.post("/mapPoints", body: dto, token: token)
    }

    func updateMapPoint(_ id: UUID, dto: UpdateMapPointDTO) async throws -> MapPointDTO {
        return try await APIService.shared.patch("/mapPoints/\(id)", body: dto)
    }

    func deleteMapPoint(_ id: UUID) async throws {
        try await APIService.shared.delete("/mapPoints/\(id)")
    }
}
