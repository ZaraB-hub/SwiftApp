
import SwiftUI

struct ReflectionView: View {

    @Bindable var viewModel: ActiveStepViewModel

    var body: some View {
        ZStack {

            AppBackground()

            VStack(spacing: 28) {

                Spacer()

                VStack(spacing: 12) {

                    Text("How do you feel now?")
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.center)

                    Text("Rate your anxiety after completing those steps")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }

                // Anxiety bubble
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 120, height: 120)
                        .shadow(radius: 12)

                    Text("\(Int(viewModel.anxietyAfter))")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.purple)
                }

                Text(anxietyLabel(for: Int(viewModel.anxietyAfter)))
                    .foregroundColor(.secondary)

             

                // Slider card
                VStack(spacing: 12) {

                    Slider(value: $viewModel.anxietyAfter, in: 1...10, step: 1)
                        .tint(.purple)

                    HStack {
                        Text("1")
                        Spacer()
                        Text("10")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.white.opacity(0.95))
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.horizontal)

                // Reflection card
                VStack(alignment: .leading, spacing: 8) {

                    Text("How did it feel? (optional)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    ZStack(alignment: .topLeading) {

                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.95))
                            .shadow(radius: 8)

                        TextEditor(text: $viewModel.reflection)
                            .padding(12)
                            .frame(height: 120)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)

                        if viewModel.reflection.isEmpty {
                            Text("It wasn't as bad as I thought...")
                                .foregroundColor(.gray)
                                .padding(18)
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()

                Button {
                    viewModel.saveAndFinish()
                } label: {
                    Text("Save & Finish")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .background(
                    LinearGradient(
                        colors: [
                            Color.purple.opacity(0.9),
                            Color.purple.opacity(0.7)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.white)
                .cornerRadius(22)
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
            .padding(.horizontal, 24)
            .padding(.top)
        }
    }


}
