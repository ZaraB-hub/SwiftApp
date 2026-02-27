import SwiftUI

struct HomeView: View {

    @State var viewModel: HomeViewModel
    @State private var showCreateTask = false

    var body: some View {
        let recentActiveTasks = Array(
            viewModel.activeTasks
                .sorted { $0.dateCreated > $1.dateCreated }
                .prefix(3)
        )

        ZStack {
            AppBackground()

            VStack(spacing: 28) {

                Spacer()

                VStack(spacing: 16) {

                
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

                NavigationLink(isActive: $showCreateTask) {
                    CreateTaskNameView(
                        viewModel: AddTaskViewModel(
                            taskService: viewModel.taskService,
                            stepService: viewModel.stepService
                        ),
                        onFlowFinished: {
                            showCreateTask = false
                        }
                    )
                } label: {
                    PrimaryActionButtonLabel(title: "Start something hard")
                }

                NavigationLink {
                    CourageLogView(
                        viewModel: CourageLogViewModel(
                            taskService: viewModel.taskService
                        )
                    )
                } label: {
                    SecondaryActionButtonLabel(title: "Courage Log")
                }

                if !recentActiveTasks.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("In Progress")
                            .font(.headline)

                        ForEach(recentActiveTasks) { task in
                            let completed = task.steps.filter { $0.isCompleted }.count
                            let total = task.steps.count
                            let shownStep = min(completed + 1, max(total, 1))

                            VStack(alignment: .leading, spacing: 12) {
                                Text(task.title)
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundColor(.primary)
                                    .lineLimit(1)

                                Text("Step \(shownStep) of \(total)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                HStack(spacing: 10) {
                                    NavigationLink {
                                        ActiveStepView(
                                            viewModel: ActiveStepViewModel(
                                                task: task,
                                                stepService: viewModel.stepService,
                                                taskService: viewModel.taskService
                                            )
                                        )
                                    } label: {
                                        PrimaryActionButtonLabel(title: "Resume Task")
                                    }
                                    .buttonStyle(.plain)

                                    Button(role: .destructive) {
                                        viewModel.deleteTask(id: task.id)
                                    } label: {
                                        Image(systemName: "trash")
                                            .font(.subheadline.weight(.semibold))
                                            .foregroundColor(.red)
                                            .frame(width: 20, height: 20)
                                            .padding(10)
                                            .background(Color.white.opacity(0.95))
                                            .cornerRadius(12)
                                    }
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white.opacity(0.92))
                            .cornerRadius(16)
                        }
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .onAppear { viewModel.loadTasks() }
    }
}

#Preview {
    HomeView(viewModel: .preview)
}
