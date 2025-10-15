//
//  User.swift
//  Bonheur_App
//
//  Created by caroletm on 04/10/2025.
//

import SwiftUI
import Foundation

class User {
    var nom: String
    var email: String
    var motDePasse : String
    var txBonheur: CGFloat
    var souvenirs : [Souvenir] = []
    var missionAcomplished : [Challenge] = []
    var mapPoints : [MapPoint] = []
    
    init(nom: String, email: String, motDePasse: String, txBonheur: CGFloat, souvenirs: [Souvenir], missionAcomplished: [Challenge], mapPoints: [MapPoint]) {
        self.nom = nom
        self.email = email
        self.motDePasse = motDePasse
        self.txBonheur = txBonheur
//        self.souvenirs = []
//        self.missionAcomplished = []
//        self.mapPoints = []
    }
}

let user = User(nom: "Jean Dupont", email: "jean.dupont@example.com", motDePasse: "azerty", txBonheur: 0.2, souvenirs: [], missionAcomplished: [], mapPoints: [])
