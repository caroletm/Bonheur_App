import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
     
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
                   
                
                VStack(spacing: 15) {
                    TextField("Nom d'utilisateur", text: $authViewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("spaceMono-Regular", size: 12))
                        .padding(.horizontal)
                    
                    TextField("Email", text: $authViewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("spaceMono-Regular", size: 12))
                        .keyboardType(.emailAddress)
                        .padding(.horizontal)
                    
                    SecureField("Mot de passe", text: $authViewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.custom("spaceMono-Regular", size: 12))
                        .padding(.horizontal)
                }
                
                Button {
                    authViewModel.signUp()
                } label: {
                    Text("S'inscrire")
                       .font(.custom("Poppins-Bold", size: 18))
                       .padding()
                       .frame(maxWidth: .infinity)
                       .background(
                           RoundedRectangle(cornerRadius: 14)
                               .fill(Color.blueDark)
                       )
                       .foregroundColor(.white)
                       .padding(.horizontal)
                       .shadow(radius: 4, y: 2)
                }
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
        .environmentObject(AuthViewModel())
}
