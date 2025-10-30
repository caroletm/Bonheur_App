//
//  UserService.swift
//  Bonheur_App
//
//  Created by caroletm on 29/10/2025.
//
import Foundation

final class UserService {
    static let shared = UserService()
    private let api = APIService.shared
    
    private init() {}
    
    // Inscription
    func signUp(username: String, email: String, password: String) async throws -> UtilisateurDTO {
        let body = UserCreateDTO(email: email, nom: username, motDePasse: password)
        return try await api.post("/users", body: body)
    }
    
    // Connexion
    func login(email: String, password: String) async throws -> String {
        let body = LoginRequest(email: email, motDePasse: password)
        // Le endpoint /users/login retourne directement un String (le token)
        let response: LoginResponse = try await api.post("/users/login", body: body)
        return response.token
    }
    
//      profil utilisateur avec le token
    func getProfile(token: String) async throws -> UtilisateurDTO {
        return try await api.get("/users/profile", token: token)
    }
}
