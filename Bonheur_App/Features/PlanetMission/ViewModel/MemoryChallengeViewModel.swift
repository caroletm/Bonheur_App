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
    var descriptionText: String = ""
    var selectedTheme: ThemeType? = nil
    var image: UIImage? = nil
    var creationDate: Date = Date()
    
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
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    func loadImage(from filename : String?) -> UIImage? {
        guard let filename = filename else { return nil}
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        return UIImage(contentsOfFile: url.path)
    }
    
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "dd/MMMM/yyyy"
        return formatter.string(from: creationDate)
    }
}
