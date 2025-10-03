//
//  Souvenir.swift
//  Bonheur_App
//
//  Created by caroletm on 15/09/2025.
//

import Foundation
import SwiftUI

class Souvenir : Identifiable, Hashable {
    var id : UUID
    var nom: String
    var photo: ImageResource?
    var description: String
    var date: Date
    var theme: SouvenirTheme
    var type : SouvenirType
    
    init(id: UUID, nom: String, photo: ImageResource?, description: String, date: Date, theme: SouvenirTheme, type: SouvenirType) {
        self.id = id
        self.nom = nom
        self.photo = photo
        self.description = description
        self.date = date
        self.theme = theme
        self.type = type
    }
    
    // MARK: - Hashable
    
    static func == (lhs: Souvenir, rhs: Souvenir) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class SouvenirCarte : Souvenir {
    var latitude: Double
    var longitude: Double
    
    init(id: UUID, nom: String, photo: ImageResource?, description: String, date: Date, theme: SouvenirTheme, type: SouvenirType, latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        super.init(id: id, nom: nom, photo: photo, description: description, date: date, theme: theme, type: .mapInsert)
    }
}

class SouvenirDefi : Souvenir {
    var isValidated: Bool
    
    init(id: UUID, nom: String, photo: ImageResource?, description: String, date: Date, theme: SouvenirTheme, type: SouvenirType, isValidated: Bool) {
        self.isValidated = isValidated
        super.init(id: id, nom: nom, photo: photo, description: description, date: date, theme: theme, type: .mission)
    }
}

func dateFromString(_ string: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    formatter.locale = Locale(identifier: "fr_FR")
    return formatter.date(from: string) ?? Date()
}

//Instanciation

let souvenirs: [Souvenir] = [
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

//protocol Souvenir : Identifiable{
//    var id: UUID { get }
//    var nom: String { get }
//    var photo: ImageResource? { get }
//    var description: String { get }
//    var date: Date { get }
//    var theme: SouvenirTheme { get }
//    var type : SouvenirType { get }
//
//}
//
//struct SouvenirCarte: Souvenir, Identifiable {
//    let id : UUID
//    let nom: String
//    let photo: ImageResource?
//    let description: String
//    let date: Date
//    let theme: SouvenirTheme
//    let type : SouvenirType
//    let latitude: Double
//    let longitude: Double
//}
//
//struct SouvenirDefi: Souvenir, Identifiable {
//    let id : UUID
//    let nom: String
//    let photo: ImageResource?
//    let description: String
//    let date: Date
//    let theme: SouvenirTheme
//    let type : SouvenirType
//    let isValidated: Bool
//}
//
