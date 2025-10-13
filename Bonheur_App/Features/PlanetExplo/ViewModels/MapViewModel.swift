//
//  MapViewModel.swift
//  Bonheur_App
//
//  Created by caroletm on 08/10/2025.
//

import Foundation
import MapKit
import CoreLocation
import Observation
import SwiftUI

@Observable

class MapViewModel: NSObject, CLLocationManagerDelegate {
    
//    CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522)
    
    //MARK: -  Map Data
    
    var places : [MapPoint] = mapPoints
    let manager = CLLocationManager()
    var userLocation : CLLocationCoordinate2D? = nil
    var cameraPosition: MapCameraPosition {
        if let loc = userLocation {
            return .region(
                MKCoordinateRegion(
                    center: loc,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            )
        } else {
            return .region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            )
        }
    }

    
    override init() {
        super.init()
        manager.delegate = self
        manager.startUpdatingLocation() // récupere les positions et met à jour la localisation
    }
    
    //MARK: - Geolocalisation
    
    func requestLocationAuthorization() {
        manager.desiredAccuracy = kCLLocationAccuracyBest // pour que ça soit précis
        manager.requestWhenInUseAuthorization() // demande l'autorisation de la localisation
    }
    
    // Crée une région centrée sur la position utilisateur (avec un span par défaut)
    func regionForUserLocation(span: CLLocationDegrees = 0.01) -> MKCoordinateRegion? {
        guard let loc = userLocation else { return nil }
        return MKCoordinateRegion(
            center: loc,
            span: MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        )
    }
    
    // Fonction utilitaire pour comparer deux coordonnées (optionnelles)
    func didLocationChange(from old: CLLocationCoordinate2D?, to new: CLLocationCoordinate2D?) -> Bool {
        guard let old = old, let new = new else { return true }
        return old.latitude != new.latitude || old.longitude != new.longitude
    }
    
    // Delegate appelé quand une nouvelle position est détectée
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        print("Position utilisateur : \(lastLocation.coordinate.latitude), \(lastLocation.coordinate.longitude)")
        DispatchQueue.main.async {
            self.userLocation = lastLocation.coordinate
        }
    }
    
    // Affiche erreur si localisation échoue
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erreur localisation: \(error.localizedDescription)")
    }
    
    func centerMap(on coordinate: CLLocationCoordinate2D) {
        _ = MKCoordinateRegion(
               center: coordinate,
               span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
           )
   //        withAnimation(.easeInOut(duration: 0.5)) {
   //            cameraPosition = .region(region)
   //        }
       }
       
       func centerOnUser() {
            guard let userLoc = userLocation else { return }
            centerMap(on: userLoc)
        }
    
    //MARK: - Convertir une adresse en mapInsert
    
    func addMapPoint(from address: String, theme: SouvenirTheme, completion: @escaping (Bool) -> Void) {
           let geocoder = CLGeocoder()
           
           geocoder.geocodeAddressString(address) { placemarks, error in
               if let error = error {
                   print("Erreur de géocodage : \(error.localizedDescription)")
                   completion(false)
                   return
               }
               
               guard let location = placemarks?.first?.location else {
                   print("Adresse introuvable")
                   completion(false)
                   return
               }
               
               let coordinate = location.coordinate
               let newPoint = MapPoint(nom: address, theme: theme, coordinate: coordinate)
               
               DispatchQueue.main.async {
                   self.places.append(newPoint)
                   completion(true)
               }
           }
       }
    
    //MARK: - Convertir des coordonnées en adresse String
    
//    func getAddress(from coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
//        let geocoder = CLGeocoder()
//        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        
//        geocoder.reverseGeocodeLocation(location) { placemarks, error in
//            if let error = error {
//                print("Erreur reverse geocoding : \(error.localizedDescription)")
//                completion(nil)
//                return
//            }
//            
//            if let placemark = placemarks?.first {
//                // Exemple : on combine le nom de la rue + la ville
//                let street = placemark.thoroughfare ?? ""
//                let city = placemark.locality ?? ""
//                completion("\(street), \(city)")
//            } else {
//                completion(nil)
//            }
//        }
//    }
    
    func getAddress(from coordinate: CLLocationCoordinate2D) async -> String? {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                let street = placemark.thoroughfare ?? ""
                let city = placemark.locality ?? ""
                let postalCode = placemark.postalCode ?? ""
                
                return "\(street), \(postalCode) \(city)"
            }
        } catch {
            print("Erreur reverse geocoding : \(error.localizedDescription)")
        }
        return nil
    }
    
    var addressFound : String? = nil
    var adressRentree : String = ""
    
    //MARK: - Ajouter des points sur la carte
    
    var mapThemeSelected : SouvenirTheme? = nil
    
}

//MARK: - Rendre CLLocationCoordinate 2D Equatable

// Wrapper pour rendre CLLocationCoordinate2D équatable facilement
struct EquatableCoordinate: Equatable {
    let coordinate: CLLocationCoordinate2D
    init(_ coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    // Compare latitudelongitude ET  pour éviter les faux déclenchements
    static func == (lhs: EquatableCoordinate, rhs: EquatableCoordinate) -> Bool {
        lhs.coordinate.latitude == rhs.coordinate.latitude &&
        lhs.coordinate.longitude == rhs.coordinate.longitude
    }

}

