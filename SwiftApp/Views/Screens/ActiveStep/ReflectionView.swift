import SwiftUI

struct ReflectionView: View {

	@Bindable var viewModel: ActiveStepViewModel

	var body: some View {
		VStack(spacing: 32) {
			Spacer()

			Text("How anxious do you feel now?")
				.font(.title2)
				.fontWeight(.semibold)
				.multilineTextAlignment(.center)

			Text("\(Int(viewModel.anxietyAfter))")
				.font(.system(size: 72, weight: .bold))
				.foregroundColor(.purple.opacity(0.8))

			Text(anxietyLabel(for: Int(viewModel.anxietyAfter)))
				.font(.subheadline)
				.foregroundColor(.secondary)

			Slider(value: $viewModel.anxietyAfter, in: 1...10, step: 1)
				.tint(.purple)
				.padding(.horizontal)

			VStack(spacing: 8) {
				Text("Any reflection? (optional)")
					.font(.subheadline)
					.foregroundColor(.secondary)

				TextField("It wasn't as bad as I thought...", text: $viewModel.reflection, axis: .vertical)
					.textFieldStyle(.roundedBorder)
					.lineLimit(3...5)
					.padding(.horizontal)
			}

			Spacer()

			Button {
				viewModel.saveAndFinish()
			} label: {
				Text("Save & Finish")
					.fontWeight(.semibold)
					.frame(maxWidth: .infinity)
					.padding()
					.background(Color.black)
					.foregroundColor(.white)
					.cornerRadius(16)
			}
			.padding(.horizontal)
			.padding(.bottom, 32)
		}
		.padding()
	}
}
