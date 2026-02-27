import SwiftUI

struct CompletedView: View {

	var viewModel: ActiveStepViewModel

	var body: some View {
        ZStack{
            AppBackground()
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
                    PrimaryActionButtonLabel(title: "How do you feel now?")
                        .padding(.horizontal,15)
                }
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
        }
	}
}

#Preview {
    CompletedView(viewModel: .preview)
}
