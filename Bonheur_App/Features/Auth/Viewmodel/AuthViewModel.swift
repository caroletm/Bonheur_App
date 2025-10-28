
import SwiftUI
import Combine

class AuthViewModel: ObservableObject {

    @Published var showLanding: Bool = true
    @Published var showSignUp: Bool = false
    @Published var showLogin: Bool = false
    
    // infos utilisateurs
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
        


    func signIn() {
        // si l'utilisateur ne rempli pas tout les champs
        guard !email.isEmpty, !password.isEmpty else {
            print("Email ou mot de passe vide")
            return
        }
        // pour voir si tout fonctionne
        print("Tentative de connexion avec \(email) / \(password)")
        // Après succès
        showLogin = false
    }
    
    func signUp() {
        guard !email.isEmpty, !password.isEmpty, !username.isEmpty else {
            print("Tous les champs doivent être remplis")
            return
        }
        print("Inscription avec \(username) / \(email) / \(password)")
        showSignUp = false
        showLogin = true
    }
}

