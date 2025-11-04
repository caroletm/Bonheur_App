//
//  CourPhiloDTO.swift
//  BonheurApp
//
//  Created by Emmanuel on 21/10/2025.
//

import Foundation

struct CourantPhiloDTO: Codable {
    var id: UUID?
    var planetePhiloId: UUID
    var nom: String
    var icon: String
    var description: String
    
    // Méthode pour convertir en enum Philosophy
       func toEnum() -> Philosophy {
           return Philosophy(rawValue: nom.lowercased()) ?? .bouddhisme
       }
    
}
// a utiliser dans le cas d'un PUT et PATCH
struct PartialCourantPhilo: Codable {
    var texte: String?
}

//@ID(key : .id) var id : UUID?
//@Parent(key : "planetePhilo_Id") var planetePhilo : PlanetePhilo
//@Field(key : "nom") var nom : String
//@Field(key : "icon") var icon : String
//@Field(key : "description") var description : String
