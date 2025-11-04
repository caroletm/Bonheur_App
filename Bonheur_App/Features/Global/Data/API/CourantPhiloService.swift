//
//  CourantPhiloService.swift
//  Bonheur_App
//
//  Created by Emmanuel on 29/10/2025.
//

import Foundation

struct CourantPhiloService {
    func getAllPhilo() async throws -> [CourantPhiloDTO] {
        try await APIService.shared.get("/courantsPhilo")
    }
}
