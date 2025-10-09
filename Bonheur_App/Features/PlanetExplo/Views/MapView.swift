//
//  MapView.swift
//  Bonheur_App
//
//  Created by caroletm on 08/10/2025.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    
    @Environment(MapViewModel.self) private var mapViewModel
    
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var lastUserLocation: EquatableCoordinate?

    var body: some View {
        
        
        MapReader { proxy in
            
            Map(initialPosition: cameraPosition)
            .mapControls {
                MapUserLocationButton() //pour le bouton de geolocalisation
                MapCompass() // pour la boussole
                MapScaleView() //pour le bouton 3D
            }
            .mapStyle(.standard(elevation: .realistic)) // style de la map en standard
            
            .onAppear {
                mapViewModel.requestLocationAuthorization()
            }
            .onChange(of: mapViewModel.userLocation.map { EquatableCoordinate($0) }) { oldValue, newValue in
                guard let new = newValue else { return }
                
                if lastUserLocation != new {
                    lastUserLocation = new
                    
                    // Mise à jour de la caméra
                    if let region = mapViewModel.regionForUserLocation() {
                        withAnimation {
                            cameraPosition = .region(region)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MapView()
        .environment(MapViewModel())
}
