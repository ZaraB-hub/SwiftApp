//
//  AnxietyView.swift
//  SwiftApp
//
//  Created by Zara Bahtanović on 22. 2. 26.
//


import SwiftUI

struct AnxietyView: View {

    @State var viewModel: AddTaskViewModel
    @State private var navigate = false
    @State private var isLoading = false

    var body: some View {
        ZStack {
            AppBackground()

            VStack(spacing: 32) {
                Spacer()

                VStack(spacing: 8) {
                    Text("How anxious does this make you?")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)

                    Text(viewModel.title)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }

                // big anxiety number
                Text("\(Int(viewModel.anxiety))")
                    .font(.system(size: 72, weight: .bold))
                    .foregroundColor(.purple.opacity(0.8))

                // label under number
                Text(anxietyLabel(for: Int(viewModel.anxiety)))
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Slider(value: $viewModel.anxiety, in: 1...10, step: 1)
                    .tint(.purple)
                    .padding(.horizontal)

                Spacer()

                NavigationLink(isActive: $navigate) {
                    if let task = viewModel.createdTask {
                        ActiveStepView(viewModel: ActiveStepViewModel(
                            task: task,
                            stepService: viewModel.stepService,
                            taskService: viewModel.taskService
                        ))                    }
                } label: { EmptyView() }

                Button {
                    isLoading = true
                    _Concurrency.Task {
                        await viewModel.createTask()
                        isLoading = false
                        navigate = true
                    }
                } label: {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Let's break it down")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0.5)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .blur(radius: 8)
                    )
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                }
                .disabled(isLoading)
                .padding(.horizontal)
                .padding(.bottom, 32)
            }
            .padding()
        }
    }

    // func anxietyLabel(for value: Int) -> String {
    //     switch value {
    //     case 1: return "Barely bothered"
    //     case 2: return "A little uneasy"
    //     case 3: return "Somewhat nervous"
    //     case 4: return "Noticeably anxious"
    //     case 5: return "Moderately stressed"
    //     case 6: return "Quite anxious"
    //     case 7: return "Very anxious"
    //     case 8: return "Really struggling"
    //     case 9: return "Extremely overwhelmed"
    //     case 10: return "Cannot function right now"
    //     default: return ""
    //     }
    // }
}

#Preview {
    NavigationStack {

        let repo = SwiftDataTaskRepository(inMemoryOnly: true)

        let stepService = StepService(repository: repo)
        let taskService = TaskServices(
            repository: repo,
            stepGenerator: StepGeneratorService()
        )
        AnxietyView(viewModel: AddTaskViewModel(
            taskService: taskService,
            stepService: stepService
        ))
    }
}
