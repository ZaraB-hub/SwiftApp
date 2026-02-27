import SwiftUI

struct CompletedView: View {

	var viewModel: ActiveStepViewModel
    @State private var animateCelebration = false

	var body: some View {
        ZStack{
            AppBackground()
            VStack(spacing: 24) {
                Spacer()
                
                ZStack {
                    ForEach(0..<12, id: \.self) { index in
                        Image(systemName: index.isMultiple(of: 2) ? "sparkle" : "circle.fill")
                            .font(.system(size: index.isMultiple(of: 2) ? 16 : 8, weight: .semibold))
                            .foregroundStyle(index.isMultiple(of: 2) ? Color.yellow.opacity(0.9) : Color.purple.opacity(0.55))
                            .offset(
                                x: animateCelebration ? confettiX(index) : confettiX(index) * 0.35,
                                y: animateCelebration ? confettiY(index) : confettiY(index) * 0.35
                            )
                            .opacity(animateCelebration ? 1 : 0.2)
                            .rotationEffect(.degrees(animateCelebration ? 280 : 0))
                            .animation(.easeOut(duration: 0.7).delay(Double(index) * 0.03), value: animateCelebration)
                    }

                    Text("🎉")
                        .font(.system(size: 80))
                        .scaleEffect(animateCelebration ? 1.08 : 0.9)
                        .animation(.spring(response: 0.45, dampingFraction: 0.65), value: animateCelebration)
                }
                .frame(height: 170)
                
                Text("You did it.")
                    .font(.system(size: 34, weight: .bold))
                
                Text("That took courage.")
                    .foregroundColor(.secondary)
                    .font(.title3)
                
                Spacer()
                
                Button {
                    AppHaptics.light()
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.86)) {
                        viewModel.showReflection = true
                    }
                } label: {
                    PrimaryActionButtonLabel(title: "How do you feel now?")
                        .padding(.horizontal,15)
                }
                .buttonStyle(PressableScaleButtonStyle())
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
        }

		.onAppear {
            AppHaptics.success()
            animateCelebration = false
            DispatchQueue.main.async {
                animateCelebration = true
            }
        }
	}

    private func confettiX(_ index: Int) -> CGFloat {
        let angle = (Double(index) / 12.0) * Double.pi * 2
        return CGFloat(cos(angle) * 95)
    }

    private func confettiY(_ index: Int) -> CGFloat {
        let angle = (Double(index) / 12.0) * Double.pi * 2
        return CGFloat(sin(angle) * 68)
    }
}

#Preview {
    CompletedView(viewModel: .preview)
}
