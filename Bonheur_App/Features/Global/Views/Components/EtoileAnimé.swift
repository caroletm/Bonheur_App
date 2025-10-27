import SwiftUI

struct StarryBackgroundView: View {
    
    @State private var glowIntensity: CGFloat = 0.3
    
    var body: some View {
        ZStack {
            // GROUPE 1 : Haut gauche
            StarGroup(
                positions: [
                    CGPoint(x: 50, y: 80),
                    CGPoint(x: 80, y: 100),
                    CGPoint(x: 60, y: 120)
                ],
                glowIntensity: glowIntensity,
                delay: 0.0
            )
            
            // GROUPE 2 : Haut centre-gauche
            StarGroup(
                positions: [
                    CGPoint(x: 150, y: 70),
                    CGPoint(x: 170, y: 95),
                    CGPoint(x: 140, y: 110)
                ],
                glowIntensity: glowIntensity,
                delay: 0.8
            )
            
            // GROUPE 3 : Haut droite
            StarGroup(
                positions: [
                    CGPoint(x: 320, y: 85),
                    CGPoint(x: 340, y: 105),
                    CGPoint(x: 310, y: 115)
                ],
                glowIntensity: glowIntensity,
                delay: 1.6
            )
        }
        .ignoresSafeArea()
        .onAppear {
            // Animation du glow
            withAnimation(
                Animation
                    .easeInOut(duration: 2.5)
                    .repeatForever(autoreverses: true)
            ) {
                glowIntensity = 0.9
            }
        }
    }
}

// Composant pour un groupe d'étoiles
struct StarGroup: View {
    let positions: [CGPoint]
    let glowIntensity: CGFloat
    let delay: Double
    
    var body: some View {
        ForEach(positions.indices, id: \.self) { index in
            Image("Star")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .position(x: positions[index].x, y: positions[index].y)
                .shadow(
                    color: .white.opacity(glowIntensity),
                    radius: 8
                )
                .shadow(
                    color: .white.opacity(glowIntensity * 0.6),
                    radius: 4
                )
                .animation(
                    Animation
                        .easeInOut(duration: 2.5)
                        .repeatForever(autoreverses: true)
                        .delay(delay + Double(index) * 0.2),
                    value: glowIntensity
                )
        }
    }
}


#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        StarryBackgroundView()
    }
}
