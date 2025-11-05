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
    
    var places : [MapPointDTO] = []
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
    
//    // Fonction utilitaire pour comparer deux coordonnées (optionnelles)
//    func didLocationChange(from old: CLLocationCoordinate2D?, to new: CLLocationCoordinate2D?) -> Bool {
//        guard let old = old, let new = new else { return true }
//        return old.latitude != new.latitude || old.longitude != new.longitude
//    }
//
    
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
    
    //MARK: - Convertir une adresse en mapPoint
    
    var nomDuLieu : String = ""
    var selectedTheme : SouvenirTheme? = nil
    var descriptionText : String = ""
    var image: UIImage? = nil
    
    func getCoordinates(from address : String) async -> CLLocationCoordinate2D? {
        let geocoder = CLGeocoder()
        
        do {
            let placemarks = try await geocoder.geocodeAddressString(address)
            
            if let location = placemarks.first?.location {
                return location.coordinate
            } else {
                print("Adresse introuvable")
                return nil
            }
        } catch {
            print("Erreur de géocodage : \(error.localizedDescription)")
            return nil
        }
    }
    
    func createMapPoint(nom: String, theme : SouvenirTheme, coordinate : CLLocationCoordinate2D) async {
        var imagePath: String? = nil
        
        if let image = image {
            imagePath = saveImageToDocuments(image: image)
//            saveImageToPhotoLibrary(image)
        }
        
        let newMapPoint = MapPointDTO(
            nom: nomDuLieu,
            photo: imagePath,
            theme: selectedTheme!,
            description: descriptionText ,
            latitude: coordinate.latitude,
            longitude: coordinate.longitude)
        places.append(newMapPoint)
        
        do {
            _ = try await service.createMapPoint(newMapPoint)
        } catch{
            print ("Erreur lors de la création du mapPoint : \(error)")
        }
    }
    
    var addressSelected : String? = nil
    var isUserLocationSelected : Bool = false
    var isManualAddressSelected : Bool = false
    
    var isValid : Bool {
        return !nomDuLieu.isEmpty && selectedTheme != nil && !descriptionText.isEmpty && addressSelected != nil
    }
    
    
    //MARK: - Convertir des coordonnées en adresse String
    
    func getAddress(from coordinate: CLLocationCoordinate2D) async -> String? {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                let number = placemark.subThoroughfare ?? ""
                let street = placemark.thoroughfare ?? ""
                let city = placemark.locality ?? ""
                let postalCode = placemark.postalCode ?? ""
                
                return "\(number) \(street),\n\(postalCode) \(city)"
            }
        } catch {
            print("Erreur reverse geocoding : \(error.localizedDescription)")
        }
        return nil
    }
    //MARK: - Reset les données de la vue à l'initial
    
    func resetForm() {
        nomDuLieu = ""
        descriptionText = ""
        selectedTheme = nil
        addressSelected = nil
        isUserLocationSelected = false
        isManualAddressSelected = false
    }
    
    
    //MARK: - Detail MapPoint
    
    var selectedMapPoint: MapPointDTO? = nil
    
    var showDetailPopup: Bool = false
    
   
    
    // MARK: - Gestion des images
    
    /// Sauvegarde une image dans le répertoire Documents de l’application.
    /// - Parameter image: L’image à sauvegarder.
    /// - Returns: Le nom du fichier sauvegardé (String) ou `nil` en cas d’erreur.
    private func saveImageToDocuments(image: UIImage) -> String?{
        guard let data = image.jpegData(compressionQuality: 0.8) else {return nil}
        
        let filename = UUID().uuidString + ".jpg"
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        do {
            try data.write(to: url)
            return filename
        } catch {
            print("erreur sauvegarde image :", error)
            return nil
        }
    }
    /// Retourne l’URL du dossier Documents de l’application.
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
//    // Sauvagarde l'image dans la librairie Photo de l'iPhone
//    
//    func saveImageToPhotoLibrary(_ image: UIImage) {
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//    }
    
    // MARK: - Chargement de l'image
        
        /// Charge une image enregistrée localement à partir de son nom de fichier.
        /// - Parameter filename: Nom du fichier image (optionnel).
        /// - Returns: L’image chargée (`UIImage`) ou `nil` si le fichier n’existe pas.
    func loadImage(from filename : String?) -> UIImage? {
        guard let filename = filename else { return nil}
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        return UIImage(contentsOfFile: url.path)
    }
    
    // MARK: - Call API : Données Back / Front
    
    private let service = MapPointService()
    
    //Recupérer les mapPoints
    func fetchMapPoints() async {
        do {
            places = try await service.getAllMapPoints()
        } catch {
            print("Erreur dans le chargement des mapPoints: \(error)")
        }
    }
    
    //Créer un mapPoint
//    func addMapPointToDB(mapPoint: MapPointDTO) async {
//        do {
//            _ = try await service.createMapPoint(mapPoint)
//        } catch{
//            print ("Erreur lors de la création du mapPoint : \(error)")
//        }
//    }
    
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


