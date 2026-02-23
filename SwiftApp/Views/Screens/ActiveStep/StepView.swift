import SwiftUI

struct StepView: View {

	var viewModel: ActiveStepViewModel

	var body: some View {
		VStack(spacing: 40) {
			Spacer()

			VStack(spacing: 8) {
				Text("One small step")
					.font(.subheadline)
					.foregroundColor(.secondary)

				let completed = viewModel.task.steps.filter { $0.isCompleted }.count
				let total = viewModel.task.steps.count

				Text("\(completed) of \(total)")
					.font(.caption)
					.foregroundColor(.secondary)

				ProgressView(value: Double(completed), total: Double(total))
					.tint(.purple)
					.padding(.horizontal, 40)
			}

			if let step = viewModel.currentStep {
				Text(step.title)
					.font(.system(size: 26, weight: .semibold))
					.multilineTextAlignment(.center)
					.padding(.horizontal, 32)
			}

			Spacer()

			VStack(spacing: 12) {
				Button {
					viewModel.completeCurrentStep()
				} label: {
					Text("Done ✓")
						.fontWeight(.semibold)
						.frame(maxWidth: .infinity)
						.padding()
						.background(Color.black)
						.foregroundColor(.white)
						.cornerRadius(16)
				}

				Button {
					viewModel.tooHard()
				} label: {
					Text("Too hard right now")
						.frame(maxWidth: .infinity)
						.padding()
						.background(Color.white.opacity(0.8))
						.foregroundColor(.black)
						.cornerRadius(16)
				}
			}
			.padding(.horizontal)
			.padding(.bottom, 32)
		}
	}
}
