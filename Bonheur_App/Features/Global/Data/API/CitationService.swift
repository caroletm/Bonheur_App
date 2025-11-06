//
//  Untitled.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//

import Foundation

struct CitationService {
    func getAllCitations() async throws -> [CitationDTO] {
        try await APIService.shared.get("/citations")
    }
}

