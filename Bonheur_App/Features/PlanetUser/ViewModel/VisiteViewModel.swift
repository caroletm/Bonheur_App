//
//  VisiteViewModel.swift
//  Bonheur_App
//
//  Created by cyrilH on 03/11/2025.
//

import Foundation
import SwiftUI

@Observable
final class VisiteViewModel {
    func createVisite(for planeteId: UUID) async {
        let dto = VisiteCreateDTO(planeteId: planeteId)
        
        do {
            _ = try await VisiteService.shared.createVisite(dto)
            print("Visite créée pour la planète \(planeteId)")
        } catch {
            print(" Erreur création visite :", error)
        }
    }
}


//@State private var visiteViewModel = VisiteViewModel()
//Task {
//            await visiteViewModel.createVisite(for: planetViewModel.planetes[index].id)
//        }

