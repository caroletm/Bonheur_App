//
//  UserDTO.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//
import Foundation

// signup
struct UserCreateDTO: Codable {
    let email: String
    let nom: String
    let motDePasse: String
}

//login
struct LoginRequest: Codable {
    let email: String
    let motDePasse: String
}

//  réponse user
struct UtilisateurDTO: Codable, Identifiable {
    let id: UUID?
    let email: String
    let nom: String
}

// Réponse du login (token)
struct LoginResponse: Codable {
    let token: String
}
//  PATCH
struct PartialUserDTO: Codable {
    let email: String?
    let nom: String?
    let motDePasse: String?
}
