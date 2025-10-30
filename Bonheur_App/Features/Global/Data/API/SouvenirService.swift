//
//  SouvenirService.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//

import Foundation

struct SouvenirService {
    
    func getAllSouvenirs() async throws -> [SouvenirDTO] {
        try await APIService.shared.get("/souvenirs")
    }

    func getSouvenirById(_ id: UUID) async throws -> SouvenirDTO {
        try await APIService.shared.get("/souvenirs/\(id)")
    }

    func createSouvenir(_ dto: SouvenirDTO) async throws -> SouvenirDTO {
        return try await APIService.shared.post("/souvenirs", body: dto)
    }

    func deleteSouvenir(_ id: UUID) async throws {
        try await APIService.shared.delete("/souvenirs/\(id)")
    }
}

