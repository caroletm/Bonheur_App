//
//  DetailMapPoint.swift
//  Bonheur_App
//
//  Created by caroletm on 16/10/2025.
//

import SwiftUI
import CoreLocation

struct DetailMapPoint: View {
    
    @Environment(NavigationViewModel.self) private var navigationViewModel
    @Environment(MapViewModel.self) private var mapViewModel
    
    var mapPoint: MapPoint
    @State var address : String?
    
    var body: some View {
        
        ZStack {
            
            RectangleFondDetail()
            VStack {
                Image(mapPoint.theme.iconName)
                    .resizable()
                    .frame(width: 65, height: 65)
                    .shadow(color : mapPoint.theme.color, radius: 15)
                Text(mapPoint.theme.title)
                    .font(.custom("Poppins-Regular", size: 12))
            }
            .offset(y: -245)
            
            VStack {
         
                    Text("Votre lieu a bien été ajouté")
                        .font(.custom("SpaceMono-Bold", size: 16))
                    
                if let address = address {
                    Text(address)
                        .font(.custom("SpaceMono-Bold", size: 14))
                        .frame(maxWidth : 200, maxHeight : 50)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .padding(5)
                    
                }
                
                if mapPoint.photo != nil {
                    HStack {
                        if let image = mapViewModel.loadImage(from: mapPoint.photo ?? "photoDog") {
                            ZStack {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 106, height: 138)
                                Image(.pointGps)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height:  40)
                                    .offset(y : 70)
                            }
                            
                            Text(mapPoint.description)
                                .frame(maxWidth : 150, maxHeight : 190)
                                .background(Color.white.opacity(0.1))
                        }
                    }
                    }else{
                        VStack{
                            Image(.pointGps)
                                .resizable()
                                .scaledToFit()
                                .frame(height:  40)
                                .padding()
                            Text(mapPoint.description)
                                .frame(maxWidth : 250, maxHeight : 120)
                                .background(Color.white.opacity(0.1))
                        }
                    }
                Button {
                    //
                }label: {
                    BoutonText(text: "OK", width: 45)
                }
                .padding()
                
            }
            .task {
                let coordinate = CLLocationCoordinate2D(latitude: mapPoint.latitude, longitude: mapPoint.longitude)
                    address = await mapViewModel.getAddress(from: coordinate)
            }
        }
    }
}

#Preview {
    ZStack{
        Color.blueDark.ignoresSafeArea(edges: .all)
        DetailMapPoint(mapPoint: mapPoints[1])
            .environment(NavigationViewModel())
            .environment(MapViewModel())
    }
}
