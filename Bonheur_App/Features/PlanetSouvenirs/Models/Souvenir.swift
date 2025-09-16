//
//  Souvenir.swift
//  Bonheur_App
//
//  Created by caroletm on 15/09/2025.
//

import Foundation
import SwiftUI

protocol Souvenir : Identifiable{
    var id: UUID { get }
    var nom: String { get }
    var photo: ImageResource? { get }
    var description: String { get }
    var date: Date { get }
    var theme: SouvenirTheme { get }
    var type : SouvenirType { get }
}

struct SouvenirCarte: Souvenir, Identifiable {
    let id : UUID
    let nom: String
    let photo: ImageResource?
    let description: String
    let date: Date
    let theme: SouvenirTheme
    let type : SouvenirType
    let latitude: Double
    let longitude: Double
}

struct SouvenirDefi: Souvenir, Identifiable {
    let id : UUID
    let nom: String
    let photo: ImageResource?
    let description: String
    let date: Date
    let theme: SouvenirTheme
    let type : SouvenirType
    let isValidated: Bool
}

//Fakedata
let souvenirs: [any Souvenir] = [
    SouvenirCarte(id : UUID(), nom: "Parc", photo: .photoVoiture, description: "Ajouté sur la map", date: Date(), theme: .inspiration, type: .mapInsert, latitude: 48.8566, longitude: 2.3522),
    SouvenirDefi(id : UUID(), nom: "Défi sourire", photo: .photoSmile, description: "Un défi relevé", date: Date(), theme: .social, type : .mission, isValidated: true),
    SouvenirCarte(id : UUID(), nom: "Parc", photo: .photoVoiture, description: "Ajouté sur la map", date: Date(), theme: .inspiration, type: .mapInsert, latitude: 48.8566, longitude: 2.3522),
    SouvenirDefi(id : UUID(), nom: "Défi sourire", photo: .photoSmile, description: "Un défi relevé", date: Date(), theme: .social, type : .mission, isValidated: true),
    SouvenirCarte(id : UUID(), nom: "Parc", photo: .photoVoiture, description: "Ajouté sur la map", date: Date(), theme: .inspiration, type: .mapInsert, latitude: 48.8566, longitude: 2.3522),
    SouvenirDefi(id : UUID(), nom: "Défi sourire", photo: .photoSmile, description: "Un défi relevé", date: Date(), theme: .social, type : .mission, isValidated: true),
    SouvenirCarte(id : UUID(), nom: "Parc", photo: .photoVoiture, description: "Ajouté sur la map", date: Date(), theme: .inspiration, type: .mapInsert, latitude: 48.8566, longitude: 2.3522),
    SouvenirDefi(id : UUID(), nom: "Défi sourire", photo: .photoSmile, description: "Un défi relevé", date: Date(), theme: .social, type : .mission, isValidated: true),
    SouvenirCarte(id : UUID(), nom: "Parc", photo: .photoVoiture, description: "Ajouté sur la map", date: Date(), theme: .inspiration, type: .mapInsert, latitude: 48.8566, longitude: 2.3522),
    SouvenirDefi(id : UUID(), nom: "Défi sourire", photo: .photoSmile, description: "Un défi relevé", date: Date(), theme: .social, type : .mission, isValidated: true),
    SouvenirCarte(id : UUID(), nom: "Parc", photo: .photoVoiture, description: "Ajouté sur la map", date: Date(), theme: .inspiration, type: .mapInsert, latitude: 48.8566, longitude: 2.3522),
    SouvenirDefi(id : UUID(), nom: "Défi sourire", photo: .photoSmile, description: "Un défi relevé", date: Date(), theme: .social, type : .mission, isValidated: true)

]

