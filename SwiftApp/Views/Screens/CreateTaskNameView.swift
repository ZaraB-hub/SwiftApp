

import SwiftUI

struct CreateTaskNameView: View {
    
    @State var viewModel: AddTaskViewModel

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("What are you avoiding right now?")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Text("Just name it. It loses power when you write it down.")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            TextField("I'm avoiding...", text: $viewModel.title)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            NavigationLink {
                AnxietyView(viewModel: viewModel)
            } label: {
                HStack {
                    Text("Continue")
                    Image(systemName: "arrow.right")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.title.isEmpty ? Color.gray : Color.black)
                .foregroundColor(.white)
                .cornerRadius(16)
            }
            .disabled(viewModel.title.isEmpty)

            Spacer()
        }
        .padding()
    }
}
