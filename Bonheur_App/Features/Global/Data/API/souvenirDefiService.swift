//
//  souvenirDefiService.swift
//  Bonheur_App
//
//  Created by cyrilH on 31/10/2025.
//
import Foundation

struct SouvenirDefiService{
    func createSouvenirDefi(_ dto: SouvenirDefiDTO)async throws -> SouvenirDefiDTO {
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            print("Aucun token trouvé dans UserDefaults")
            throw URLError(.userAuthenticationRequired)
        }
        print("Token trouvé : \(token.prefix(25))...")
       return try await APIService.shared.post("/souvenirDefi", body: dto, token: token)
        
    }
    
    
}

