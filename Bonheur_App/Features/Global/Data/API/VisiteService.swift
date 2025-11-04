//
//  VisiteService.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//

import Foundation

final class VisiteService {
    static let shared = VisiteService()
        private init() {}
    func createVisite(_ dto: VisiteCreateDTO) async throws -> VisiteDTO {
            guard let token = UserDefaults.standard.string(forKey: "authToken") else {
                throw URLError(.userAuthenticationRequired)
            }
            return try await APIService.shared.post("/visites", body: dto, token: token)
        }
}

