import SwiftUI

struct ConfettiView: View {
    @State private var particles: [ConfettiParticle] = []
    let isActive: Bool
    
    var body: some View {
        Canvas { context, size in
            for particle in particles {
                var contextCopy = context
                contextCopy.opacity = particle.opacity
                
                let rect = CGRect(
                    x: particle.x - 5,
                    y: particle.y - 5,
                    width: 10,
                    height: 10
                )
                
                contextCopy.fill(
                    Circle(),
                    with: .color(particle.color)
                )
                
                contextCopy.draw(
                    Circle().path(in: rect),
                    with: .color(particle.color)
                )
            }
        }
        .ignoresSafeArea()
        .onAppear {
            if isActive {
                startConfetti()
            }
        }
    }
    
    private func startConfetti() {
        let colors: [Color] = [.purple, .mint, .blue, .pink, .yellow]
        
        for _ in 0..<50 {
            let x = CGFloat.random(in: 0...UIScreen.main.bounds.width)
            let y = CGFloat.random(in: -50...0)
            let color = colors.randomElement() ?? .purple
            let vx = CGFloat.random(in: -3...3)
            let vy = CGFloat.random(in: 2...5)
            
            var particle = ConfettiParticle(
                x: x,
                y: y,
                vx: vx,
                vy: vy,
                color: color,
                opacity: 1.0
            )
            
            particles.append(particle)
            
            animateParticle(&particle)
        }
    }
    
    private func animateParticle(_ particle: inout ConfettiParticle) {
        let duration: TimeInterval = Double.random(in: 2...4)
        var animatedParticle = particle
        
        withAnimation(.linear(duration: duration)) {
            animatedParticle.y = UIScreen.main.bounds.height + 100
            animatedParticle.opacity = 0
            
            if let index = particles.firstIndex(where: { $0.id == particle.id }) {
                particles[index] = animatedParticle
            }
        }
    }
}

struct ConfettiParticle: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    let vx: CGFloat
    let vy: CGFloat
    let color: Color
    var opacity: Double
}
