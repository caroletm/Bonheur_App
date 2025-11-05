//
//  PlanetViewModel.swift
//  Bonheur_App
//
//  Created by caroletm on 26/09/2025.
//

import SwiftUI
import Foundation
import Observation

@Observable

class PlanetViewModel {
    
    //MARK: - Data
    
    var planetes : [Planete] = []
    
    //MARK: - Call API Front/Back
    
    let service = PlaneteService()
    
    func fetchPlanetes() async {
        do {
            let dtos = try await service.getAllPlanetes()
            let allPlanetes = dtos.map { Planete(from: $0) }
            
            planetes = allPlanetes.map { planete in
                switch planete.nom {
                    
                case "Explora":
                    planete.position = CGPoint(x: -100, y: 120)
                    planete.circleSize = CGSize(width: 132, height: 132)
                    planete.circleRelativeOffset = CGPoint(x: 0, y: 0)
                    planete.route = .planeteExplo
                    
                case "Harmonia":
                    planete.position = CGPoint(x: -100, y: 300)
                    planete.circleSize = CGSize(width: 140, height: 140)
                    planete.circleRelativeOffset = CGPoint(x: 0, y: 0)
                    planete.route = .planeteMusic

                    
                case "Lumen":
                    planete.position = CGPoint(x: 100, y: 120)
                    planete.circleSize = CGSize(width: 140, height: 140)
                    planete.circleRelativeOffset = CGPoint(x: 0, y: 0)
                    planete.route = .planetePhilo
                    
                case "Challengis":
                    planete.position = CGPoint(x: 120, y: 300)
                    planete.circleSize = CGSize(width: 130, height: 130)
                    planete.circleRelativeOffset = CGPoint(x: -2, y: 0)
                    planete.route = .planeteMission
                    
                case "Memoria":
                    planete.position = CGPoint(x: 0, y: 440)
                    planete.circleSize = CGSize(width: 140, height: 140)
                    planete.circleRelativeOffset = CGPoint(x: 0, y: 0)
                    planete.route = .planeteSouvenirs
                    
                default:
                    break
                }
                return planete
            }
            
        } catch {
            print("Erreur de chargement des planètes:", error)
        }
    }
    
}
