//
//  CourantPhiloViewModel.swift
//  Bonheur_App
//
//  Created by Larderet on 04/11/2025.
//

import SwiftUI
import Observation

@Observable
class CourantPhiloViewModel {
    
    var philosophy: [CourantPhiloDTO] = []
    var selectedPhilosophy : Philosophy? = nil
    var showPopUp: Bool = false
    
    
    //MARK: - CallAPI
    
    func fetchCourantPhilosophy() async {
        do {
            let dtos = try await CourantPhiloService().getAllPhilo()
            philosophy = dtos

            // Si tu veux en plus convertir en enum :
            let mapped = dtos.compactMap { dto in
                Philosophy(rawValue: dto.nom.lowercased())
            }

            print("Philosophies disponibles :", mapped)
        } catch {
            print("Erreur dans le chargement des courants Philo: \(error)")
        }
    }
}
