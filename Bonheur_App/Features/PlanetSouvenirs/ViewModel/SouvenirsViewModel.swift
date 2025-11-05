//
//  SouvenirsViewModel.swift
//  Bonheur_App
//
//  Created by caroletm on 17/09/2025.
//

import SwiftUI
import Foundation
import Observation

// MARK: - ViewModel des souvenirs
/// `SouvenirsViewModel` gère la logique liée aux souvenirs créés par l’utilisateur.
/// Il permet :
/// - de filtrer les souvenirs par thème, date ou type,
/// - de créer de nouveaux souvenirs (liés à une mission ou une carte),
/// - de sauvegarder les images localement,
/// - et de formater les dates pour l’affichage.
@Observable
class SouvenirsViewModel {
    
    // MARK: - Données principales
    /// Liste complète des souvenirs récupérés depuis le backend.
    var souvenirsData : [SouvenirDTO] = []
    
    // MARK: - Regroupement par mois
    /// Regroupe les souvenirs par mois et année, triés du plus récent au plus ancien.
    func groupSouvenirsByMonth(_ souvenirs: [SouvenirDTO]) -> [(key: String, value: [SouvenirDTO])] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "MMMM yyyy"
        
        let grouped = Dictionary(grouping: souvenirs) { souvenir in
            formatter.string(from: souvenir.date)
        }
        return grouped.sorted { $0.key > $1.key }
    }
    
    // MARK: - Formatage d’une date
    /// Formate une date au format français lisible, ex. `"07 octobre 2025"`.
    func dateFormatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
    
    // MARK: - Filtres
    /// Contient les filtres actuellement appliqués.
    var filters = SouvenirFilter()
    
    /// Retourne les souvenirs filtrés selon les critères actifs.
    var filteredSouvenirs : [SouvenirDTO] {
        souvenirsData.filter { souvenir in
            
            if let month = filters.month,
               Calendar.current.component(.month, from: souvenir.date) != month {
                return false
            }
            
            if let year = filters.year,
               Calendar.current.component(.year, from: souvenir.date) != year {
                return false
            }
            
            if filters.isDefi && souvenir.type != .mission  {
                return false
            }
            
            if filters.isMap && souvenir.type != .mapInsert  {
                return false
            }
            
            if !filters.theme.isEmpty && !filters.theme.contains(souvenir.theme) {
                return false
            }
            return true
        }
    }
    
    // MARK: - Conversion de la date des filtres en texte
    /// Retourne une représentation textuelle du mois et de l’année sélectionnés dans les filtres.
    func dateEnString() -> String {
        
        let months = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin",
                      "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"]
        
        var result : [String] = []
        
        if let month = filters.month {
            result.append(months[month-1])
        }
        
        if let year = filters.year {
            result.append("\(year)")
        }
        return result.joined(separator : " ")
    }
    
    // MARK: - Réinitialisation des filtres
    /// Supprime tous les filtres actifs.
    func resetFilters() {
        filters = SouvenirFilter()
    }
    
    // MARK: - Données de création de souvenir
    var descriptionText: String = ""
    var selectedTheme: SouvenirTheme? = nil
    var image: UIImage? = nil
    var creationDate: Date = Date()
    /// Vérifie si les champs du formulaire de création sont valides.
    var isValid: Bool {
        return selectedTheme != nil &&
        !descriptionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func imageToString(_ image: UIImage?) -> String? {
        image?.jpegData(compressionQuality: 0.8)?.base64EncodedString()
    }
    
    // MARK: - Création d’un souvenir (mission)
    /// Construit un `SouvenirDefiDTO` et le sauvegarde via le service distant.
    /// - Parameters:
    ///   - name: Nom du défi.
    ///   - missionID: Identifiant de la mission associée.
    /// - Returns: Un `SouvenirDTO` si la création réussit, sinon `nil`.
    func buildSouvenirChallenge(name: String,missionID: UUID)async throws-> SouvenirDTO? {
        guard let theme = selectedTheme else {return nil}
        var imagePath: String? = nil
        if let image = image {
            imagePath = saveImageToDocuments(image:image)
        }
        
        let dto = SouvenirDefiDTO(
            id: nil,
            nom: name,
            photo: imagePath,
            theme: theme,
            description: descriptionText,
            planetedMission: missionID
        )
        
        do {
            let response = try await SouvenirDefiService().createSouvenirDefi(dto)
            let souvenir = SouvenirDTO(
                id: response.id ?? UUID(),
                nom: response.nom,
                description: response.description,
                theme: response.theme,
                type: .mission,
                date: creationDate,
                isValidated: true
            )
            souvenirsData.append(souvenir)
            return souvenir
            
        } catch {
            print("erreur création Souvenir:\(error)")
            return nil
        }
        
    }
    
    // MARK: - Création d’un souvenir carte
    /// Crée un souvenir géolocalisé à partir d’un nom, thème et coordonnées GPS.
    func createSouvenirCarte(name: String, latitude : CGFloat, longitude : CGFloat) async {
        guard let theme = selectedTheme else { return }
        var imagePath: String? = nil
        
        if let image = image {
            imagePath = saveImageToDocuments(image: image)
            saveImageToPhotoLibrary(image)
        }
        let souvenir = SouvenirDTO(
            id : UUID(),
            nom: name,
            photo: imagePath,
            description: descriptionText,
            theme: theme,
            type : .mapInsert,
            date: creationDate,
            latitude: latitude,
            longitude: longitude
        )
        souvenirsData.append(souvenir)
        
        do {
            _ = try await service.createSouvenir(souvenir)
        }catch{
            print ("Erreur lors de la création du mapPoint : \(error)")
        }
    }
    
    // MARK: - Réinitialisation des formulaires
    /// Réinitialise le formulaire de création de souvenir mission.
    func resetFormMission() {
        image = nil
        descriptionText = ""
        creationDate = Date()
        selectedTheme = nil
    }
    
    /// Réinitialise le formulaire de création de souvenir carte.
    func resetFormCarte() {
        image = nil
        descriptionText = ""
        selectedTheme = nil
    }
    
    // MARK: - Show PopUp validation
    
    var showValidationPopup: Bool = false
    
    // MARK: - Call API front backend
    
    private let service = SouvenirService()
    
    /// Récupère tous les souvenirs depuis le backend.
    func fetchSouvenirs() async {
        do {
            souvenirsData = try await service.getAllSouvenirs()
        } catch {
            print("Erreur dans le chargement des souvenirs: \(error)")
        }
    }
    
    // MARK: - Gestion des images
    /// Sauvegarde une image dans le répertoire Documents local.
    /// - Parameter image: Image à sauvegarder.
    /// - Returns: Le nom du fichier sauvegardé.
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
    
    /// Enregistre une image dans la photothèque de l’iPhone.
    func saveImageToPhotoLibrary(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    // MARK: - Chargement de l'image
    /// Charge une image enregistrée localement à partir de son nom de fichier.
    /// - Parameter filename: Nom du fichier image (optionnel).
    /// - Returns: L’image chargée (`UIImage`) ou `nil` si le fichier n’existe pas.
    func loadImage(from filename : String?) -> UIImage? {
        guard let filename = filename else { return nil}
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        return UIImage(contentsOfFile: url.path)
    }
    
    // MARK: - Formatage de la date
    /// Formate la date de création en français (jour/mois/année).
    /// - Returns: Une chaîne du type `"07/10/2025"`.
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: creationDate)
    }
    
}
