//
//  ImagePicker.swift
//  Bonheur_App
//
//  Created by cyrilH on 01/10/2025.
//

import Foundation
import SwiftUI
import UIKit
    /// `ImagePicker` est une structure SwiftUI qui permet d’intégrer le sélecteur d’images natif d’iOS (`UIImagePickerController`)
    /// dans une interface SwiftUI.
    /// Elle gère la sélection d’une image depuis la bibliothèque ou l’appareil photo.
struct ImagePicker : UIViewControllerRepresentable {
    // MARK: - Propriétés
    
        /// Type de source pour la sélection d’image (par défaut : bibliothèque de photos).
        /// Peut être `.photoLibrary`, `.camera` ou `.savedPhotosAlbum`.
    var sourceType : UIImagePickerController.SourceType = .photoLibrary
        /// Liaison avec la vue SwiftUI : stocke l’image sélectionnée.
    @Binding var selectedImage: UIImage?
    
    // MARK: - Méthodes UIViewControllerRepresentable
        
        /// Crée un coordinateur qui servira d’intermédiaire entre UIKit et SwiftUI.
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    /// Crée et configure le contrôleur UIKit (`UIImagePickerController`).
    /// - Parameter context: Contexte SwiftUI utilisé pour la communication entre UIKit et SwiftUI.
    /// - Returns: Une instance configurée de `UIImagePickerController`.
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
    /// Méthode requise par le protocole, ici vide car aucune mise à jour dynamique n’est nécessaire.
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    // MARK: - Classe interne : Coordinator
        
        /// Le coordinateur agit comme "pont" entre le contrôleur UIKit (`UIImagePickerController`)
        /// et la vue SwiftUI. Il gère les actions de sélection et d’annulation.
    class Coordinator : NSObject,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        /// Méthode appelée quand l’utilisateur choisit une image.
            /// - Parameters:
            ///   - picker: Le contrôleur d’images.
            ///   - info: Dictionnaire contenant les informations sur l’image choisie.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage{
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
        /// Méthode appelée quand l’utilisateur annule la sélection.
        /// Ferme simplement le sélecteur d’images.
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        
    }
    
                    
}
