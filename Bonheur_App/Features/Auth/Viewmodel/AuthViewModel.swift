
import SwiftUI
import Combine
import Observation

// MARK: - ViewModel d'authentification
/// Gère l'ensemble de la logique d'authentification :
/// - Affichage (Landing / Login / Signup)
/// - Connexion / Inscription / Déconnexion
/// - Chargement du profil utilisateur
/// - Persistance du token d'authentification
@Observable
class AuthViewModel {
    // MARK: - États d'affichage
    var showLanding: Bool = true
    var showSignUp: Bool = false
    var showLogin: Bool = false
    
    // MARK: - Informations utilisateur
    var username = ""
    var email = ""
    var password = ""
    
    // MARK: - État d'authentification
    var isAuthenticated: Bool = false
    var currentUser: UtilisateurDTO?
    var authToken: String?
    var errorMessage: String?
    var isLoading: Bool = false
    
    // MARK: - Services et stockage
    private let userService = UserService.shared
    private let tokenKey = "authToken"
    
    // MARK: - Initialisation
    init(){
        checkAuthentication()
    }
    // MARK: - Vérifie l'authentification existante
    /// Récupère le token sauvegardé (si présent) et tente de charger le profil associé.
    func checkAuthentication() {
        if let savedToken = UserDefaults.standard.string(forKey: tokenKey) {
            authToken = savedToken
            // Essaye de récupérer le profil
            Task {
                await loadUserProfile()
            }
        }
    }
    
    // MARK: - Chargement du profil utilisateur
    /// Charge le profil utilisateur à partir du token JWT stocké.
    /// Si le token est invalide ou expiré, l'utilisateur est déconnecté.
    @MainActor
    func loadUserProfile() async {
        guard let token = authToken else {
            isAuthenticated = false
            return
        }
        isLoading = true
        
        do {
            currentUser = try await userService.getProfile(token: token)
            isAuthenticated = true
            showLanding = false
            showLogin = false
            showSignUp = false
            print("Profil chargé: \(currentUser?.nom ?? "Unknown")")
        } catch {
            // Token invalide ou expiré
            print("Token invalide ou expiré")
            logout()
        }
        
        isLoading = false
    }
    
    
    // MARK: - Connexion utilisateur
    /// Authentifie l'utilisateur à partir de son email et mot de passe.
    /// Sauvegarde le token et charge le profil en cas de succès.
    @MainActor
    func signIn() async {
        // Validation des champs
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email ou mot de passe vide"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            // Appel API login
            let token = try await userService.login(email: email, password: password)
            
            // Sauvegarde le token
            authToken = token
            UserDefaults.standard.set(token, forKey: tokenKey)
            
            // Charge le profil utilisateur
            await loadUserProfile()
            
            // Réinitialise le mot de passe
            password = ""
            
            print(" Connexion réussie avec token: \(token.prefix(20))...")
            
        } catch URLError.userAuthenticationRequired {
            errorMessage = "Email ou mot de passe incorrect"
            print(" Authentification échouée")
        } catch {
            errorMessage = "Erreur de connexion. Vérifiez votre connexion."
            print(" Erreur de connexion: \(error)")
        }
        
        isLoading = false
    }
    
    // MARK: - Inscription utilisateur
    /// Crée un nouveau compte utilisateur avec validation des champs.
    /// Redirige vers l'écran de connexion en cas de succès.
    @MainActor
    func signUp() async {
        // Validation des champs
        guard !email.isEmpty, !password.isEmpty, !username.isEmpty else {
            errorMessage = "Tous les champs doivent être remplis"
            return
        }
        
        // Validation email basique
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Email invalide"
            return
        }
        
        // Validation mot de passe
        guard password.count >= 6 else {
            errorMessage = "Le mot de passe doit contenir au moins 6 caractères"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            // Appel API signup
            let user = try await userService.signUp(username: username, email: email, password: password)
            
            print("Inscription réussie pour: \(user.nom)")
            
            // Redirection vers login
            showSignUp = false
            showLogin = true
            
            // Réinitialise le mot de passe mais garde email et username
            password = ""
            
            // Message de succès (optionnel)
            errorMessage = nil
            
        } catch {
            errorMessage = "Erreur lors de l'inscription. Email peut-être déjà utilisé."
            print(" Erreur d'inscription: \(error)")
        }
        
        isLoading = false
    }
    
    // MARK: - Déconnexion utilisateur
    /// Supprime le token et réinitialise l’état d’authentification.
    @MainActor
    func logout() {
        // Clear le token
        authToken = nil
        currentUser = nil
        isAuthenticated = false
        UserDefaults.standard.removeObject(forKey: tokenKey)
        
        // Réinitialise les champs
        email = ""
        password = ""
        username = ""
        errorMessage = nil
        
        // Retour à la landing page
        showLanding = true
        showLogin = false
        showSignUp = false
        
        print(" Déconnexion réussie")
    }
    
    // MARK: - Réinitialisation des erreurs
    /// Supprime le message d’erreur affiché.
    func clearError() {
        errorMessage = nil
    }
    
}

