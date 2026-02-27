//
//  AnxietyView.swift
//  SwiftApp
//
//  Created by Zara Bahtanović on 22. 2. 26.

//

import SwiftUI

struct AnxietyView: View {

    @State var viewModel: AddTaskViewModel
    var onFlowFinished: (() -> Void)? = nil
    @State private var navigate = false
    @State private var isLoading = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {

            AppBackground()

            VStack(spacing: 28) {

            
                Spacer()

                VStack(spacing: 12) {

                    Text("How anxious do you feel?")
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.center)

                    
                }

                // Anxiety bubble
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 120, height: 120)
                        .shadow(radius: 12)

                    Text("\(viewModel.anxiety)")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.purple)
                }

                Text(anxietyLabel(for: Int(viewModel.anxiety)))
                    .foregroundColor(.secondary)

                // Slider card
                VStack(spacing: 12) {

                    Slider(value:$viewModel.anxiety,in: 1...10, step: 1)
                    HStack {
                        Text("1")
                        Spacer()
                        Text("10")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)

                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(20)
                .shadow(radius: 10)

                Spacer()

                NavigationLink(isActive: $navigate) {
                    if let task = viewModel.createdTask {
                        ActiveStepView(
                            viewModel: ActiveStepViewModel(
                                task: task,
                                stepService: viewModel.stepService,
                                taskService: viewModel.taskService
                            ),
                            onFlowFinished: onFlowFinished
                        )
                    }
                } label: { EmptyView() }

                Button {
                    isLoading = true
                    _Concurrency.Task {
                        await viewModel.createTask()
                        isLoading = false
                        navigate = true
                    }
                } label: {
                    PrimaryActionButtonLabel(title: "Continue", isLoading: isLoading)
                }
                .padding(.horizontal)
                .padding(.bottom, 32)
                .disabled(isLoading)
            }
            .padding(.horizontal, 24)
            .padding(.top)
        }
    }
}
#Preview {
    NavigationStack {

        let repo = SwiftDataTaskRepository(inMemoryOnly: true)

        let stepService = StepService(repository: repo)
        let taskService = TaskServices(
            repository: repo,
            stepGenerator: StepGeneratorService()
        )

        AnxietyView(
            viewModel: AddTaskViewModel(
                taskService: taskService,
                stepService: stepService
            )
        )
    }
}

