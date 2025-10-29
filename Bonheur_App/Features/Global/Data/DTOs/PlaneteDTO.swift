//
//  PlaneteDTO.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//

import Foundation

struct PlaneteDTO: Codable,Identifiable {
    var id: UUID?
    var nom : String
    var description : String
    var image : String
    var onboardingDescription : String
    var iconOnboarding : String
    var backgroundPlanete : String
}

struct UpdatePlaneteDTO : Codable {
    var nom : String?
    var description : String?
    var image : String?
    var onboardingDescription : String?
    var iconOnboarding : String?
    var backgroundPlanete : String?
}
