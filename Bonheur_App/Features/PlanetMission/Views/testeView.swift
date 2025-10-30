//
//  SwiftUIView.swift
//  Bonheur_App
//
//  Created by cyrilH on 27/10/2025.
//

import SwiftUI
    
struct SwiftUIView: View {
  
    @State private var cita = CitationViewModelApi()
    var body: some View {
        VStack{
            List(cita.citation, id: \.id){ item in
                Text(item.texte)
            }
                
                }.task { // AJOUT: Charge les citations depuis l'API au lancement de la vue
                    await cita.fetchCitation()
        }
    }
            
}

#Preview {
    SwiftUIView()
}
