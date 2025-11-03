//
//  mapPoint.swift
//  Bonheur_App
//
//  Created by caroletm on 09/10/2025.
//

import SwiftUI
import Foundation
import CoreLocation

class MapPoint : Identifiable, Hashable {
    
    let id = UUID()
    let nom : String
    let photo : String?
    let theme : SouvenirTheme
    let description : String
    let latitude: Double
    let longitude: Double
    
    init(nom: String, photo : String?, description : String, theme: SouvenirTheme, latitude: Double, longitude: Double) {
        self.nom = nom
        self.photo = photo
        self.description = description
        self.theme = theme
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // MARK: - Hashable
    
    static func == (lhs: MapPoint, rhs: MapPoint) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

let mapPoints: [MapPointDTO] = [
    MapPointDTO(nom: "Simplon", photo: "photoDog",  theme: .apprentissage, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum accumsan iaculis odio, vel rutrum magna imperdiet vel. Nunc quis sagittis orci. Proin interdum ac ex non elementum. Nulla scelerisque tellus et justo porta congue. Integer luctus lectus vel iaculis lacinia. Nullam porta urna ut aliquam viverra. Maecenas in tortor efficitur, viverra urna eget, placerat sem. Nam euismod nisi sed quam viverra mattis. Quisque faucibus, mauris in dictum dapibus, nulla dolor pulvinar massa, vitae varius ex erat eget nulla.", latitude: 48.854699219973625, longitude: 2.435966996632539),
    MapPointDTO(nom: "Métro", photo: "", theme: .social, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum accumsan iaculis odio, vel rutrum magna imperdiet vel. Nunc quis sagittis orci. Proin interdum ac ex non elementum. Nulla scelerisque tellus et justo porta congue. Integer luctus lectus vel iaculis lacinia. Nullam porta urna ut aliquam viverra. Maecenas in tortor efficitur, viverra urna eget, placerat sem. Nam euismod nisi sed quam viverra mattis. Quisque faucibus, mauris in dictum dapibus, nulla dolor pulvinar massa, vitae varius ex erat eget nulla.", latitude: 48.85772153332712, longitude: 2.4357114297413385),
    MapPointDTO(nom: "Maison de l'art", photo: "photoSmile", theme: .energie, description: "HelloWord", latitude: 48.861780219087784, longitude: 2.4413059667895727),
    MapPointDTO(nom: "Café de potes", photo: nil, theme: .energie, description: "HelloWord", latitude: 48.8622179008456, longitude: 2.4364069667699884),
]

//class MapPoint : Identifiable {
//    let id = UUID()
//    let nom : String
//    let theme : SouvenirTheme
//    let coordinate : CLLocationCoordinate2D
//
//    init(nom: String, theme: SouvenirTheme, coordinate: CLLocationCoordinate2D) {
//        self.nom = nom
//        self.theme = theme
//        self.coordinate = coordinate
//    }
//}
//
//let mapPoints: [MapPoint] = [
//    MapPoint(nom: "Simplon", theme: .apprentissage, coordinate: CLLocationCoordinate2D(latitude: 48.854699219973625, longitude: 2.435966996632539)),
//    MapPoint(nom: "Métro", theme: .social, coordinate: CLLocationCoordinate2D(latitude: 48.85772153332712, longitude: 2.4357114297413385)),
//    MapPoint(nom: "Maison de l'art", theme: .energie, coordinate: CLLocationCoordinate2D(latitude: 48.861780219087784, longitude: 2.4413059667895727)),
//    MapPoint(nom: "Café de potes", theme: .energie, coordinate: CLLocationCoordinate2D(latitude: 48.8622179008456, longitude: 2.4364069667699884)),
//    MapPoint(nom: "Parc des idées", theme: .apprentissage, coordinate: CLLocationCoordinate2D(latitude: 48.865321, longitude: 2.440112)),
//    MapPoint(nom: "Studio Zen", theme: .inspiration, coordinate: CLLocationCoordinate2D(latitude: 48.864102, longitude: 2.438255)),
//    MapPoint(nom: "Librairie du Bonheur", theme: .apprentissage, coordinate: CLLocationCoordinate2D(latitude: 48.863589, longitude: 2.441856)),
//    MapPoint(nom: "Boulangerie du Sourire", theme: .social, coordinate: CLLocationCoordinate2D(latitude: 48.865780, longitude: 2.437918)),
//    MapPoint(nom: "Jardin des Rêves", theme: .social, coordinate: CLLocationCoordinate2D(latitude: 48.866230, longitude: 2.439670)),
//    MapPoint(nom: "Atelier du Soleil", theme: .energie, coordinate: CLLocationCoordinate2D(latitude: 48.863412, longitude: 2.437502)),
//    MapPoint(nom: "Terrasse des Copains", theme: .inspiration, coordinate: CLLocationCoordinate2D(latitude: 48.864930, longitude: 2.436980))
//    
//]
