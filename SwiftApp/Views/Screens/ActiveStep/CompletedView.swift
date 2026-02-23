import SwiftUI

struct CompletedView: View {

	var viewModel: ActiveStepViewModel

	var body: some View {
		VStack(spacing: 24) {
			Spacer()

			Text("🎉")
				.font(.system(size: 80))

			Text("You did it.")
				.font(.system(size: 34, weight: .bold))

			Text("That took courage.")
				.foregroundColor(.secondary)
				.font(.title3)

			Spacer()

			Button {
				viewModel.showReflection = true
			} label: {
				Text("How do you feel now?")
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
	}
}
