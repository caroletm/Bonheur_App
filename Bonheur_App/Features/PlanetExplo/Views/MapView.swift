//
//  MapView.swift
//  Bonheur_App
//
//  Created by caroletm on 08/10/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Environment(MapViewModel.self) private var mapViewModel
    @State private var cameraPosition: MapCameraPosition = .automatic
    
     var body: some View {
         
         Map(initialPosition: cameraPosition)    }
}

#Preview {
    MapView()
        .environment(MapViewModel())
}
