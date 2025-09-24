import SwiftUI

struct PlanetUserView: View {
    var body: some View {
        ZStack(alignment: .top){
            // Image de fond d'ecran qui remplit tout l'écran
            Image("BackgroundUser")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            //ICONE PLANETES
            Image("PlanetExplora")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .offset(x: -100, y: 120)
            Image("cercle")//cercle Explora
                .resizable()
                .scaledToFit()
                .frame(width: 145, height: 145)
                .offset(x: -94, y: 116)
            
            Image("PlanetMissions")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150 )
                .offset(x: 100, y: 300)
            Image("cercle")//cercle Mission
                .resizable()
                .scaledToFit()
                .frame(width: 135, height: 135)
                .offset(x: 107, y: 309)
            
            Image("PlanetMusic")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .offset(x: -100, y: 300)
            Image("cercle")//cercle Music
                .resizable()
                .scaledToFit()
                .frame(width: 143, height: 143)
                .offset(x: -93, y: 297)
            
            Image("PlanetPhilosophie")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .offset(x: 100, y: 120)
            Image("cercle")//cercle Philosophie
                .resizable()
                .scaledToFit()
                .frame(width: 135, height: 135)
                .offset(x: 104, y: 129)
            
            Image("PlanetSouvenirs")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .offset(x: 0, y: 450)
            Image("cercle")//cercle Souvenir
                .resizable()
                .scaledToFit()
                .frame(width: 148, height: 148)
                .offset(x: 8, y: 445)
            // LES CERCLE SONT A ANIMER
            
            //Souvenir du jour
            Image("SouvenirPola.")
                .resizable()
                .scaledToFit()
                .frame(width: 85, height: 85)
                .offset(x: 145, y: 530)
            
            // Contenu au premier plan
            VStack {
                Spacer() // Pour centrer le texte ou le positionner
                
                Text("Choisis ta destination")
                    .font(.custom("SpaceMono-Regular", size: 22))
                    .foregroundStyle(.white)
                    .padding(.top, -380)
                
                Spacer()
            }
        }
    }
}

#Preview {
    PlanetUserView()
}
