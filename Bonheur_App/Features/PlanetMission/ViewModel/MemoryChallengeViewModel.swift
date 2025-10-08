//
//  MemoryChallengeViewModel.swift
//  Bonheur_App
//
//  Created by cyrilH on 01/10/2025.
//

import Foundation
import SwiftUI
@Observable
class MemoryChallengeViewModel{
    
    // MARK: - Propriétés
    var descriptionText: String = ""
    var selectedTheme: ThemeType? = nil
    var image: UIImage? = nil
    var creationDate: Date = Date()
    var isValid: Bool {
        return selectedTheme != nil &&
               !descriptionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    // MARK: - Construction du modèle
    /// Construit un objet `MemoryChallenge` prêt à être enregistré ou affiché.
    /// - Parameter name: Nom du défi mémoire.
    /// - Returns: Un objet `MemoryChallenge` si toutes les données sont valides, sinon `nil`.
    func buildChallenge(name: String)-> MemoryChallenge?{
        guard let theme = selectedTheme else {return nil}
        var imagePath: String? = nil
        if let image = image {
            imagePath = saveImageToDocuments(image:image)
        }
        return MemoryChallenge(
            nameMemory: name,
            descriptionMemory: descriptionText,
            imageMemory: imagePath,
            themeMemory: theme,
            creationDate: formattedDate()
        )
    }
    
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
        formatter.dateFormat = "dd/MMMM/yyyy"
        return formatter.string(from: creationDate)
    }
   
}
