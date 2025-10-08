//
//  ThemeMusic.swift
//  Bonheur_App
//
//  Created by Apprenant156 on 08/10/2025.
//
import Foundation
import SwiftUI

// Un thème musical avec un nom, un fichier son et un logo
struct ThemeMusic: Identifiable {
    let id = UUID()
    var nom: String
    var musique: String
    var logo: ImageResource
}
