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

func dateFromString(_ string: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    formatter.locale = Locale(identifier: "fr_FR")
    return formatter.date(from: string) ?? Date()
}

//Fakedata
let souvenirs: [any Souvenir] = [
    SouvenirCarte(id : UUID(), nom: "Parc", photo: .photoVoiture, description: "J’adore ce parc, il me donne l’impression de m’évader de la ville. Entre les arbres, le petit lac et les enfants qui jouent, je retrouve toujours un peu de calme et de sérénité.", date: dateFromString("20/01/2025"), theme: .inspiration, type: .mapInsert, latitude: 48.8566, longitude: 2.3522),
    SouvenirDefi(id : UUID(), nom: "Défi sourire", photo: .photoSmile, description: "J’adore ce parc, il me donne l’impression de m’évader de la ville. Entre les arbres, le petit lac et les enfants qui jouent, je retrouve toujours un peu de calme et de sérénité.", date: dateFromString("02/02/2025"), theme: .social, type : .mission, isValidated: true),
    SouvenirCarte(id : UUID(), nom: "Parc", photo: .photoVoiture, description: "J’adore ce parc, il me donne l’impression de m’évader de la ville. Entre les arbres, le petit lac et les enfants qui jouent, je retrouve toujours un peu de calme et de sérénité.", date: dateFromString("02/02/2025"), theme: .apprentissage, type: .mapInsert, latitude: 48.8566, longitude: 2.3522),
    SouvenirDefi(id : UUID(), nom: "Défi sourire", photo: .photoSmile, description: "J’adore ce parc, il me donne l’impression de m’évader de la ville. Entre les arbres, le petit lac et les enfants qui jouent, je retrouve toujours un peu de calme et de sérénité.", date: dateFromString("02/02/2025"), theme: .social, type : .mission, isValidated: true),
    SouvenirCarte(id : UUID(), nom: "Parc", photo: .photoVoiture, description: "J’adore ce parc, il me donne l’impression de m’évader de la ville. Entre les arbres, le petit lac et les enfants qui jouent, je retrouve toujours un peu de calme et de sérénité.", date: dateFromString("02/02/2025"), theme: .energie, type: .mapInsert, latitude: 48.8566, longitude: 2.3522),
    SouvenirDefi(id : UUID(), nom: "Défi sourire", photo: .photoSmile, description:"J’adore ce parc, il me donne l’impression de m’évader de la ville. Entre les arbres, le petit lac et les enfants qui jouent, je retrouve toujours un peu de calme et de sérénité.", date: dateFromString("20/07/2025"), theme: .inspiration, type : .mission, isValidated: true),
    SouvenirCarte(id : UUID(), nom: "Parc", photo: .photoVoiture, description: "J’adore ce parc, il me donne l’impression de m’évader de la ville. Entre les arbres, le petit lac et les enfants qui jouent, je retrouve toujours un peu de calme et de sérénité.", date: dateFromString("20/07/2025"), theme: .social, type: .mapInsert, latitude: 48.8566, longitude: 2.3522),
    SouvenirDefi(id : UUID(), nom: "Défi sourire", photo: .photoSmile, description: "J’adore ce parc, il me donne l’impression de m’évader de la ville. Entre les arbres, le petit lac et les enfants qui jouent, je retrouve toujours un peu de calme et de sérénité.", date: dateFromString("20/08/2025"), theme: .apprentissage, type : .mission, isValidated: true),
    SouvenirCarte(id : UUID(), nom: "Parc", photo: .photoVoiture, description: "J’adore ce parc, il me donne l’impression de m’évader de la ville. Entre les arbres, le petit lac et les enfants qui jouent, je retrouve toujours un peu de calme et de sérénité.", date:dateFromString("20/09/2025"), theme: .energie, type: .mapInsert, latitude: 48.8566, longitude: 2.3522),
    SouvenirDefi(id : UUID(), nom: "Défi sourire", photo: .photoSmile, description: "J’adore ce parc, il me donne l’impression de m’évader de la ville. Entre les arbres, le petit lac et les enfants qui jouent, je retrouve toujours un peu de calme et de sérénité.", date: dateFromString("20/09/2025"), theme: .inspiration, type : .mission, isValidated: true),
    SouvenirCarte(id : UUID(), nom: "Parc", photo: .photoVoiture, description: "J’adore ce parc, il me donne l’impression de m’évader de la ville. Entre les arbres, le petit lac et les enfants qui jouent, je retrouve toujours un peu de calme et de sérénité.", date: dateFromString("20/09/2025"), theme: .social, type: .mapInsert, latitude: 48.8566, longitude: 2.3522),
    SouvenirDefi(id : UUID(), nom: "Défi sourire", photo: .photoSmile, description: "J’adore ce parc, il me donne l’impression de m’évader de la ville. Entre les arbres, le petit lac et les enfants qui jouent, je retrouve toujours un peu de calme et de sérénité.", date: dateFromString("20/09/2025"), theme: .apprentissage, type : .mission, isValidated: true)

]




