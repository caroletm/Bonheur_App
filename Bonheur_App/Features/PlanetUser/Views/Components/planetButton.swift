import SwiftUI


// Composant réutilisable pour chaque planète-bouton avec animation
struct PlanetButton: View {
    @Environment(NavigationViewModel.self) private var navigationViewModel

    let planet: Planete
    @State private var isPressed = false
    @State private var rotationAngle = 0.0
    @State private var currentPosition: CGPoint = .zero
    @State private var breathingScale = 1.06
    
    let rocketPosition: CGPoint
    let animationDelay: Double
    let breathingPhaseOffset: Double

    
    var body: some View {
        Button(action: {
            navigationViewModel.path = NavigationPath()
            navigationViewModel.path.append(AppRoute.landing(planete: planet))
        }) {
            ZStack {
                // Cercle d'animation rotatif - avec bounce synchronisé + respiration
                Image("cercle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: planet.circleSize.width,
                           height: planet.circleSize.height)
                    .rotationEffect(.degrees(rotationAngle))
                    .offset(x: planet.circleRelativeOffset.x,
                            y: planet.circleRelativeOffset.y)
                    .scaleEffect((isPressed ? 1.05 : 1.0) * breathingScale)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                    .allowsHitTesting(false)
                
                // Image de la planète - avec bounce synchronisé + respiration
                Image(planet.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .scaleEffect((isPressed ? 1.05 : 1.0) * breathingScale)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                
                // Titre de la planète - avec bounce synchronisé + respiration
                Text(planet.nom)
                    .font(.custom("SpaceMono-Regular", size: 14))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 1, y: 1)
                    .offset(x: 0,
                            y:max(planet.circleSize.height/2, 75) + 15)
                    .scaleEffect((isPressed ? 1.05 : 1.0) * breathingScale)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
                    .allowsHitTesting(false)
                
            }
        }
        .buttonStyle(PlainButtonStyle())
        .contentShape(Circle())
        .frame(width: 150, height: 150)
        .offset(x: currentPosition.x, y: currentPosition.y)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
        .onAppear {
            currentPosition = rocketPosition
            // Animation de voyage de la fusée vers la position finale
            withAnimation(.easeOut(duration: 1.0).delay(animationDelay)) {
                currentPosition = planet.position
            }
            
            // Animation de rotation continue du cercle
            withAnimation(.linear(duration: 15.0).repeatForever(autoreverses: false).delay(animationDelay + 0.5)) {
                rotationAngle = 360.0
            }
            
            // Animation de respiration désynchronisée
            withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true).delay(animationDelay + 1.0 + breathingPhaseOffset)) {
                breathingScale = 1.03
            }
        }
    }
}
#Preview {
    PlaneteUser()
        .environment(PlanetViewModel())
        .environment(NavigationViewModel())
        .environment(SouvenirsViewModel())
}
