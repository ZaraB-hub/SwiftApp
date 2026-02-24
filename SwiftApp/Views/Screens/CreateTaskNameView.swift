
import SwiftUI

struct CreateTaskNameView: View {

    @State var viewModel: AddTaskViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {

            AppBackground()

            VStack(spacing: 28) {

                // Back button
                HStack {
                    BackCircleButton {
                        dismiss()
                    }

                    Spacer()
                }

                Spacer()

                VStack(spacing: 12) {

                    Text("What are you avoiding right now?")
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.center)

                    Text("It's okay. There's no judgment here.")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }

                // Text card
                ZStack(alignment: .topLeading) {

                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(radius: 10)

                    TextEditor(text: $viewModel.title)
                        .padding(12)
                        .frame(height: 120)
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)

                    if viewModel.title.isEmpty {
                        Text("e.g. Sending that difficult email...")
                            .foregroundColor(.gray)
                            .padding(18)
                    }
                }

                // Continue button
                NavigationLink {
                    AnxietyView(viewModel: viewModel)
                } label: {
                    if viewModel.title.isEmpty {
                        SecondaryActionButtonLabel(title: "Continue")
                            .foregroundColor(.gray)
                    } else {
                        PrimaryActionButtonLabel(title: "Continue")
                    }
                }
                .disabled(viewModel.title.isEmpty)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top)
        }
    }
}
