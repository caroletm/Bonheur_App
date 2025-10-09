//
//  mapPoint.swift
//  Bonheur_App
//
//  Created by caroletm on 09/10/2025.
//

import SwiftUI
import Foundation

class MapPoint: Identifiable {
    var id: UUID = UUID()
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
