
import SwiftUI

struct HomeView: View {

    @State var viewModel: HomeViewModel

    var body: some View {
        ZStack {
            AppBackground()

            VStack(spacing: 28) {

                Spacer()

                VStack(spacing: 16) {

                    // Icon container
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.9))
                            .frame(width: 72, height: 72)
                            .shadow(radius: 8)

                        Image(systemName: "leaf")
                            .font(.system(size: 30))
                            .foregroundColor(.purple)
                    }

                    Text("Courage")
                        .font(.system(size: 36, weight: .bold))

                    Text("Breathe. Let's begin.")
                        .foregroundColor(.secondary)
                }

                // Primary button
                NavigationLink {
                    CreateTaskNameView(
                        viewModel: AddTaskViewModel(
                            taskService: viewModel.taskService,
                            stepService: viewModel.stepService
                        )
                    )
                } label: {
                    Text("Start something hard")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
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
                }

                // Secondary button
                NavigationLink {
                    CourageLogView(
                        viewModel: CourageLogViewModel(
                            taskService: viewModel.taskService
                        )
                    )
                } label: {
                    Text("Courage Log")
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(22)
                }

                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .onAppear { viewModel.loadTasks() }
    }
}
