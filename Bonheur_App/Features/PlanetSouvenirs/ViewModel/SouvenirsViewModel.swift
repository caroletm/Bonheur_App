//
//  SouvenirsViewModel.swift
//  Bonheur_App
//
//  Created by caroletm on 17/09/2025.
//

import SwiftUI
import Foundation
import Observation

@Observable

class SouvenirsViewModel {
    
    //MARK: - Data
    
    var souvenirsData : [Souvenir] = souvenirs
    
    func groupSouvenirsByMonth(_ souvenirs: [Souvenir]) -> [(key: String, value: [Souvenir])] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "MMMM yyyy"
        
        let grouped = Dictionary(grouping: souvenirs) { souvenir in
            formatter.string(from: souvenir.date)
        }
        return grouped.sorted { $0.key > $1.key }
    }
    
    func dateFormatter(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
    
    //MARK: - Filters
    
    var filters = SouvenirFilter()
    
    var filteredSouvenirs : [Souvenir] {
        
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
    
    func resetFilters() {
        filters = SouvenirFilter()
    }
    
    // MARK: - Création des souvenirs
    
    var descriptionText: String = ""
    var selectedTheme: SouvenirTheme? = nil
    var image: UIImage? = nil
    var creationDate: Date = Date()
    var isValid: Bool {
        return selectedTheme != nil &&
               !descriptionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // MARK: - Création du SouvenirDefi
    /// Construit un objet `MemoryChallenge` prêt à être enregistré ou affiché.
    /// - Parameter name: Nom du défi mémoire.
    /// - Returns: Un objet `MemoryChallenge` si toutes les données sont valides, sinon `nil`.
    ///
    func buildSouvenirChallenge(name: String) {
        guard let theme = selectedTheme else {return }
        var imagePath: String? = nil
        if let image = image {
            imagePath = saveImageToDocuments(image:image)
        }else{
            imagePath = nil
        }
        
        let souvenir = SouvenirDefi(
            id: UUID(),
            nom: name,
            photo: imagePath,
            description: descriptionText,
            date: creationDate,
            theme: theme,
            type: .mission,
            isValidated: true
        )
        souvenirsData.append(souvenir)
    }
    
    //MARK: - Création du SouvenirCarte
    
    func createSouvenirCarte(name: String, latitude : CGFloat, longitude : CGFloat) {
        guard let theme = selectedTheme else { return }
        var imagePath: String? = nil
        
        if let image = image {
            imagePath = saveImageToDocuments(image: image)
        }
       let souvenir = SouvenirCarte(
            id : UUID(),
            nom: name,
            photo: imagePath,
            description: descriptionText,
            date: creationDate,
            theme: theme,
            type : .mapInsert,
            latitude: latitude,
            longitude: longitude
        )
        souvenirsData.append(souvenir)
    }
    
//
//    private func createPost(imageName: String) {
//        let nouveauPost = Post(
//            creatorId: baseViewModel.user.id,
//            title: challenge.name,
//            image: imageName,
//            date: Date(),
//            level: challenge.level,
//            likes: 0,
//            durationHours: 0,
//            durationMinutes: 0,
//            isChallenge: true,
//            challengeId: challenge.id
//        )
//
//        baseViewModel.postsVM.insert(nouveauPost, at: 0)
//    }
//    func buildSouvenirCarte(nom: String)-> SouvenirCarte? {
//        
//    }
    
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
        
    /// Formate la date de création en français (jour mois année).
    /// - Returns: Une chaîne de type `"07/octobre/2025"`.
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: creationDate)
    }
}
