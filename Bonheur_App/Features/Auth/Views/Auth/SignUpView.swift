import SwiftUI

struct SignUpView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    
    var body: some View {
        @Bindable var viewModel = authViewModel
        ZStack {
            
            Image("BackgroundUser2")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                Text("HAPPYVERSE")
                    .font(.custom("SpaceMono-Bold", size: 22))
                    .foregroundColor(.black)
                // Message d'erreur
                if let errorMessage = authViewModel.errorMessage {
                    Text(errorMessage)
                        .font(.custom("SpaceMono-Regular", size: 12))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                
                VStack(spacing: 15) {
                    TextField("Nom d'utilisateur", text: $viewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("spaceMono-Regular", size: 12))
                        .padding(.horizontal)
                    
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("spaceMono-Regular", size: 12))
                        .keyboardType(.emailAddress)
                        .padding(.horizontal)
                    
                    SecureField("Mot de passe", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("spaceMono-Regular", size: 12))
                        .padding(.horizontal)
                }
                
                Button {
                    Task {
                        await authViewModel.signUp()
                    }
                } label: {
                    if authViewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                    } else {
                        Text("S'inscrire")
                            .font(.custom("Poppins-Bold", size: 18))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                    }
                    //                    Text("S'inscrire")
                    //                       .font(.custom("Poppins-Bold", size: 18))
                    //                       .padding()
                    //                       .frame(maxWidth: .infinity)
                    //                       .background(
                    //                           RoundedRectangle(cornerRadius: 14)
                    //                               .fill(Color.blueDark)
                    //                       )
                    //                       .foregroundColor(.white)
                    //                       .padding(.horizontal)
                    //                       .shadow(radius: 4, y: 2)
                }
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(authViewModel.isLoading ? Color.gray : Color.blueDark)
                )
                .padding(.horizontal)
                .shadow(radius: 4, y: 2)
                .disabled(authViewModel.isLoading)
                .padding(.top, 20)
                
                
                // 🔹 Texte mixte : une partie statique et une partie cliquable
                HStack(spacing: 4) {
                    Text("Déjà un compte ?")
                        .foregroundColor(.black)
                        .font(.custom("Poppins-Light", size: 14))
                    
                    Button {
                        withAnimation {
                            authViewModel.showSignUp = false
                            authViewModel.showLogin = true
                            authViewModel.clearError()
                        }
                    } label: {
                        Text("Connectez-vous")
                            .font(.custom("Poppins-SemiBold", size: 14))
                            .foregroundColor(Color.blueDark)
                            .underline(false)
                    }
                }
                .padding(.top, 10)
                
                Spacer()
            }
        }
    }
}

#Preview {
    SignUpView()
        .environment(AuthViewModel())
}
