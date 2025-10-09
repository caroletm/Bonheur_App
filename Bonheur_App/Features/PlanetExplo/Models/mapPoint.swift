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

let mapPoints: [MapPoint] = [MapPoint(nom: "Simplon", theme: .apprentissage, coordinate: CLLocationCoordinate2D(latitude: 48.854699219973625, longitude: 2.435966996632539))]
