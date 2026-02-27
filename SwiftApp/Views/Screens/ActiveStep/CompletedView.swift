import SwiftUI

struct CompletedView: View {

    var viewModel: ActiveStepViewModel
    @State private var animateCelebration = false
    @State private var revealText = false
    @State private var hasScheduledSequence = false
    @State private var animateWorkItem: DispatchWorkItem?
    @State private var revealWorkItem: DispatchWorkItem?
    @State private var advanceWorkItem: DispatchWorkItem?
    private let confettiCount = 18

    var body: some View {
        ZStack {
            AppBackground()

            VStack(spacing: 24) {
                Spacer()

                ZStack {
                    ForEach(0..<confettiCount, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 3, style: .continuous)
                            .fill(confettiColor(index).opacity(0.92))
                            .frame(width: confettiWidth(index), height: 8)
                            .offset(
                                x: animateCelebration ? confettiX(index) : confettiX(index) * 0.08,
                                y: animateCelebration ? confettiY(index) : confettiY(index) * 0.08
                            )
                            .opacity(animateCelebration ? 1 : 0)
                            .rotationEffect(.degrees(animateCelebration ? confettiRotation(index) : 0))
                            .animation(.easeOut(duration: 0.82).delay(Double(index) * 0.02), value: animateCelebration)
                    }

                    Text("🎉")
                        .font(.system(size: 80))
                        .scaleEffect(animateCelebration ? 1.1 : 0.78)
                        .animation(.spring(response: 0.45, dampingFraction: 0.65), value: animateCelebration)
                }
                .frame(height: 170)

                VStack(spacing: 8) {
                    Text("You did it.")
                        .font(.system(size: 34, weight: .bold))

                    Text("That took courage.")
                        .foregroundColor(.secondary)
                        .font(.title3)
                }
                .opacity(revealText ? 1 : 0)
                .offset(y: revealText ? 0 : 10)
                .animation(.easeOut(duration: 0.68), value: revealText)

                Spacer()
            }
        }
        .onAppear {
            playCelebrationAndAdvance()
        }
        .onDisappear {
            cancelPendingSequence()
        }
    }

    private func confettiX(_ index: Int) -> CGFloat {
        let angle = (Double(index) / Double(confettiCount)) * Double.pi * 2
        return CGFloat(cos(angle) * 108)
    }

    private func confettiY(_ index: Int) -> CGFloat {
        let angle = (Double(index) / Double(confettiCount)) * Double.pi * 2
        return CGFloat(sin(angle) * 78)
    }

    private func confettiRotation(_ index: Int) -> Double {
        Double((index * 37) % 360 + 120)
    }

    private func confettiWidth(_ index: Int) -> CGFloat {
        index.isMultiple(of: 2) ? 14 : 10
    }

    private func confettiColor(_ index: Int) -> Color {
        let palette: [Color] = [
            Color(red: 0.98, green: 0.73, blue: 0.82),
            Color(red: 0.99, green: 0.80, blue: 0.63),
            Color(red: 0.73, green: 0.87, blue: 0.99),
            Color(red: 0.75, green: 0.90, blue: 0.78),
            Color(red: 0.84, green: 0.79, blue: 0.98)
        ]
        return palette[index % palette.count]
    }

    private func playCelebrationAndAdvance() {
        guard !hasScheduledSequence else { return }
        hasScheduledSequence = true

        AppHaptics.success()
        animateCelebration = false
        revealText = false

        let animateItem = DispatchWorkItem {
            animateCelebration = true
        }
        animateWorkItem = animateItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16, execute: animateItem)

        let revealItem = DispatchWorkItem {
            revealText = true
        }
        revealWorkItem = revealItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.66, execute: revealItem)

        let advanceItem = DispatchWorkItem {
            guard !viewModel.showReflection else { return }
            withAnimation(.spring(response: 0.35, dampingFraction: 0.86)) {
                viewModel.showReflection = true
            }
        }
        advanceWorkItem = advanceItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.11, execute: advanceItem)
    }

    private func cancelPendingSequence() {
        animateWorkItem?.cancel()
        revealWorkItem?.cancel()
        advanceWorkItem?.cancel()
        animateWorkItem = nil
        revealWorkItem = nil
        advanceWorkItem = nil
        hasScheduledSequence = false
    }
}

#Preview {
    CompletedView(viewModel: .preview)
}
