//
//  PlaneteService.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//

import Foundation

struct PlaneteService {
    
    func getAllPlanetes() async throws -> [PlaneteDTO] {
         return try await APIService.shared.get("/planetes")
    }
}
