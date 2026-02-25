//
//  AnalyticsView.swift
//  SwiftApp
//
//  Created by Zara Bahtanović on 25. 2. 26.
//

import SwiftUI

struct AnalyticsView: View {
    let taskService: TaskServices
    @State private var completedTasks: [Task] = []

    private var averageReduction: Double {
        let reductions = completedTasks.compactMap { $0.anxietyReduction }
        guard !reductions.isEmpty else { return 0 }
        let total = reductions.reduce(0, +)
        return Double(total) / Double(reductions.count)
    }

    var body: some View {
        ZStack {
            AppBackground()

            VStack(alignment: .leading, spacing: 16) {
                Text("Analytics")
                    .font(.system(size: 34, weight: .bold))

                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Avg point reduction")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(String(format: "%.1f", averageReduction))
                            .font(.title2.weight(.bold))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white.opacity(0.92))
                    .cornerRadius(16)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Total tasks")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(completedTasks.count)")
                            .font(.title2.weight(.bold))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white.opacity(0.92))
                    .cornerRadius(16)
                }

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 24)
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            completedTasks = taskService.getTasks().filter { $0.status == .completed }
        }
    }
}

#Preview {
    let repo = SwiftDataTaskRepository(inMemoryOnly: true)

    let service = TaskServices(
        repository: repo,
        stepGenerator: StepGeneratorService()
    )

    return NavigationStack {
        AnalyticsView(taskService: service)
    }
}
