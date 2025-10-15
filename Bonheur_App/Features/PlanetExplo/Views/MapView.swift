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
    @Environment(NavigationViewModel.self) private var navigationViewModel
    @Environment(SouvenirsViewModel.self) private var souvenirsViewModel
    
    @State private var lastUserLocation: EquatableCoordinate?
    
    var body: some View {
        
        
        MapReader { proxy in
            
            Map(initialPosition: mapViewModel.cameraPosition) {
                ForEach(mapViewModel.places) { place in
                    
                    let coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                    
                    Annotation(place.nom, coordinate: coordinate) {
                        Button {
//                            navigationViewModel.path.append(AppRoute.planeteUserTest)
                        }label:{
                            Image(place.theme.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                        }
                    }
                }
                if let userLoc = mapViewModel.userLocation {
        
                    Annotation("Moi", coordinate: userLoc) {
                        Image(.pointGps)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                }
            }
            .mapControls {
                MapUserLocationButton() //pour le bouton de geolocalisation
                MapCompass() // pour la boussole
                MapScaleView() //pour le bouton 3D
            }
            .mapStyle(.standard(elevation: .realistic)) // style de la map en standard
            
            .onAppear {
                mapViewModel.requestLocationAuthorization()
                mapViewModel.centerOnUser()
            }
            .onChange(of: mapViewModel.userLocation.map { EquatableCoordinate($0) }) {
                mapViewModel.centerOnUser()
            }
        }
    }
}

#Preview {
    MapView()
        .environment(MapViewModel())
        .environment(NavigationViewModel())
        .environment(SouvenirsViewModel())
}
