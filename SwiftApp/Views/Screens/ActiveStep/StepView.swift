
import SwiftUI

struct StepView: View {

    var viewModel: ActiveStepViewModel

    var body: some View {
        ZStack {

            AppBackground()

            VStack(spacing: 28) {

                VStack(spacing: 8) {

                    let completed = viewModel.task.steps.filter { $0.isCompleted }.count
                    let total = viewModel.task.steps.count

                    Text("Step \(completed + 1) of \(total)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    ProgressView(value: Double(completed), total: Double(total))
                        .tint(.purple)
                        .padding(.horizontal)
                }

                Spacer()

                Text("One small step")
                    .font(.system(size: 30, weight: .bold))

                // Step card
                if let step = viewModel.currentStep {
                    Text(step.title)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .padding(24)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.95))
                        .cornerRadius(24)
                        .shadow(radius: 10)
                        .padding(.horizontal)
                }

                Spacer()

                VStack(spacing: 16) {

                    
                    Button {
                        viewModel.completeCurrentStep()
                    } label: {
                        PrimaryActionButtonLabel(title: "Done")
                    }

                    
                    Button {
                        viewModel.tooHard()
                    } label: {
                        SecondaryActionButtonLabel(title: "Too hard right now")
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 32)

                Text("×  Can't do this now")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.bottom)
            }
        }
    }
}
