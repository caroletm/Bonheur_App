//
//  CitationViewModel.swift
//  BonheurApp
//
//  Created by Claude on 27/10/2025.
//

import SwiftUI
import Observation

@Observable
class CitationViewModel {
    
    // MARK: - Properties
    
    /// Liste des citations disponibles
    var citations: [CitationDTO] = []
    
    /// Citation actuellement affichée
    var currentCitation: String = "« On ne trouve pas le bonheur, on le cultive »"
    
    /// État de chargement
    var isLoading: Bool = false
    
    /// Message d'erreur éventuel
    var errorMessage: String?

    // MARK: - Methods
    
    /// Charge les citations par défaut (fallback)
    private func loadDefaultCitations() {
        citations = [
            CitationDTO(texte: "« On ne trouve pas le bonheur, on le cultive »"),
            CitationDTO(texte: "« Le bonheur n'est pas une destination, c'est une façon de voyager »"),
            CitationDTO(texte: "« Le bonheur, c'est de continuer à désirer ce qu'on possède »"),
            CitationDTO(texte: "« Le secret du bonheur, c'est la liberté. Et le secret de la liberté, c'est le courage »"),
            CitationDTO(texte: "« Le bonheur est la seule chose qui se double si on le partage »"),
            CitationDTO(texte: "« Il n'y a qu'un devoir, c'est d'être heureux »"),
            CitationDTO(texte: "« Le bonheur n'est pas au sommet de la montagne, mais dans la façon de la gravir »"),
            CitationDTO(texte: "« Chaque jour est une nouvelle chance de bonheur »"),
            CitationDTO(texte: "« Le bonheur est un parfum que l'on ne peut répandre sur autrui sans en faire rejaillir quelques gouttes sur soi-même »"),
            CitationDTO(texte: "« Le bonheur, c'est de le chercher »")
        ]
    }
    

    //MARK: Call API Emmanuel

    let citationService = CitationService()
    
    func fetchCitation() async {
        
        do {
            citations = try await citationService.getAllCitations()
        }
        catch {
            errorMessage = "Erreur de chargement: \(error.localizedDescription)"
            print("Erreur lors du chargement des citations: \(error)")
        }
    }
    
    //MARK: Generer des citations random
    
    func generateRandomCitation() -> String {
        let randomCitation = citations.randomElement()?.texte ?? "Aucune citation disponible"
        return randomCitation
    }



}
