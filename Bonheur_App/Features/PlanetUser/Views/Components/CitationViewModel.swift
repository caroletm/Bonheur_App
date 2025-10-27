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
    var citations: [Citation] = []
    
    /// Citation actuellement affichée
    var currentCitation: String = "« On ne trouve pas le bonheur, on le cultive »"
    
    /// État de chargement
    var isLoading: Bool = false
    
    /// Message d'erreur éventuel
    var errorMessage: String?
    
    // MARK: - Initialization
    
    init() {
        // Citations par défaut en cas d'échec de chargement depuis l'API
        loadDefaultCitations()
        // Sélectionner une citation aléatoire au démarrage
        selectRandomCitation()
    }
    
    // MARK: - Methods
    
    /// Charge les citations par défaut (fallback)
    private func loadDefaultCitations() {
        citations = [
            Citation(text: "« On ne trouve pas le bonheur, on le cultive »"),
            Citation(text: "« Le bonheur n'est pas une destination, c'est une façon de voyager »"),
            Citation(text: "« Le bonheur, c'est de continuer à désirer ce qu'on possède »"),
            Citation(text: "« Le secret du bonheur, c'est la liberté. Et le secret de la liberté, c'est le courage »"),
            Citation(text: "« Le bonheur est la seule chose qui se double si on le partage »"),
            Citation(text: "« Il n'y a qu'un devoir, c'est d'être heureux »"),
            Citation(text: "« Le bonheur n'est pas au sommet de la montagne, mais dans la façon de la gravir »"),
            Citation(text: "« Chaque jour est une nouvelle chance de bonheur »"),
            Citation(text: "« Le bonheur est un parfum que l'on ne peut répandre sur autrui sans en faire rejaillir quelques gouttes sur soi-même »"),
            Citation(text: "« Le bonheur, c'est de le chercher »")
        ]
    }
    
    /// Sélectionne une citation aléatoire parmi la liste
    func selectRandomCitation() {
        guard !citations.isEmpty else {
            currentCitation = "« On ne trouve pas le bonheur, on le cultive »"
            return
        }
        
        if let randomCitation = citations.randomElement() {
            currentCitation = randomCitation.text
        }
    }
    
    /// Charge les citations depuis l'API Vapor
    @MainActor
    func fetchCitations() async {
        isLoading = true
        errorMessage = nil
        
        // URL de votre API Vapor (à adapter selon votre configuration)
        guard let url = URL(string: "http://localhost:8080/citations") else {
            errorMessage = "URL invalide"
            isLoading = false
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let decoder = JSONDecoder()
            let fetchedCitations = try decoder.decode([Citation].self, from: data)
            
            if !fetchedCitations.isEmpty {
                citations = fetchedCitations
                selectRandomCitation()
            }
            
            isLoading = false
            
        } catch {
            errorMessage = "Erreur de chargement: \(error.localizedDescription)"
            isLoading = false
            print("Erreur lors du chargement des citations: \(error)")
        }
    }
    
    /// Rafraîchit la citation affichée (pour un bouton de rafraîchissement optionnel)
    func refreshCitation() {
        selectRandomCitation()
    }
}

// MARK: - Citation Model

struct Citation: Codable, Identifiable {
    var id: UUID?
    var text: String
    
    init(id: UUID? = nil, text: String) {
        self.id = id ?? UUID()
        self.text = text
    }
}
