//
//  mapPoint.swift
//  Bonheur_App
//
//  Created by caroletm on 09/10/2025.
//

import SwiftUI
import Foundation
import CoreLocation

class MapPoint : Identifiable {
    let id = UUID()
    let nom : String
    let theme : SouvenirTheme
    let description : String
    let latitude: Double
    let longitude: Double
    
    init(nom: String, description : String, theme: SouvenirTheme, latitude: Double, longitude: Double) {
        self.nom = nom
        self.description = description
        self.theme = theme
        self.latitude = latitude
        self.longitude = longitude
    }
}

let mapPoints: [MapPoint] = [
    MapPoint(nom: "Simplon", description: "HelloWord", theme: .apprentissage, latitude: 48.854699219973625, longitude: 2.435966996632539),
    MapPoint(nom: "Métro", description: "HelloWord", theme: .social, latitude: 48.85772153332712, longitude: 2.4357114297413385),
    MapPoint(nom: "Maison de l'art", description: "HelloWord", theme: .energie, latitude: 48.861780219087784, longitude: 2.4413059667895727),
    MapPoint(nom: "Café de potes", description: "HelloWord", theme: .energie, latitude: 48.8622179008456, longitude: 2.4364069667699884),
    MapPoint(nom: "Parc des idées", description: "HelloWord", theme: .apprentissage, latitude: 48.865321, longitude: 2.440112),
    MapPoint(nom: "Studio Zen", description: "HelloWord", theme: .inspiration, latitude: 48.864102, longitude: 2.438255),
    MapPoint(nom: "Librairie du Bonheur", description: "HelloWord", theme: .apprentissage, latitude: 48.863589, longitude: 2.441856),
    MapPoint(nom: "Boulangerie du Sourire", description: "HelloWord", theme: .social, latitude: 48.865780, longitude: 2.437918),
    MapPoint(nom: "Jardin des Rêves", description: "HelloWord", theme: .social, latitude: 48.866230, longitude: 2.439670),
    MapPoint(nom: "Atelier du Soleil", description: "HelloWord", theme: .energie, latitude: 48.863412, longitude: 2.437502),
    MapPoint(nom: "Terrasse des Copains", description: "HelloWord", theme: .inspiration, latitude: 48.864930, longitude: 2.436980)
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
