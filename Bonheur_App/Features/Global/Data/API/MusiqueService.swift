//
//  MusiqueService.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//

import Foundation

struct MusiqueService {
    func getAllMusiques() async throws -> [MusicDTO] {
        try await APIService.shared.get("/musiques")
    }
}
