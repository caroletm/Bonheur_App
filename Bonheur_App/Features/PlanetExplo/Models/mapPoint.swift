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
    let coordinate : CLLocationCoordinate2D
    
    init(nom: String, theme: SouvenirTheme, coordinate: CLLocationCoordinate2D) {
        self.nom = nom
        self.theme = theme
        self.coordinate = coordinate
    }
}

let mapPoints: [MapPoint] = [
    MapPoint(nom: "Simplon", theme: .apprentissage, coordinate: CLLocationCoordinate2D(latitude: 48.854699219973625, longitude: 2.435966996632539)),
    MapPoint(nom: "Métro", theme: .social, coordinate: CLLocationCoordinate2D(latitude: 48.85772153332712, longitude: 2.4357114297413385)),
    MapPoint(nom: "Maison de l'art", theme: .inspiration, coordinate: CLLocationCoordinate2D(latitude: 48.861780219087784, longitude: 2.4413059667895727)),
    MapPoint(nom: "Café de potes", theme: .energie, coordinate: CLLocationCoordinate2D(latitude: 48.8622179008456, longitude: 2.4364069667699884))

]
