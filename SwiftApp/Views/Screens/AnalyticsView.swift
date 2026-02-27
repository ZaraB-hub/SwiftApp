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

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    private var averageReduction: Double {
        let reductions = completedTasks.compactMap { $0.anxietyReduction }
        guard !reductions.isEmpty else { return 0 }
        let total = reductions.reduce(0, +)
        return Double(total) / Double(reductions.count)
    }

    private var totalImpact: Int {
        completedTasks.compactMap(\.anxietyReduction).reduce(0, +)
    }

    private var completionDays: [Date] {
        let calendar = Calendar.current
        let normalized = completedTasks.map { calendar.startOfDay(for: $0.dateCompleted ?? $0.dateCreated) }
        let unique = Set(normalized)
        return unique.sorted(by: >)
    }

    private var currentStreak: Int {
        let calendar = Calendar.current
        var streak = 0
        var currentDay = calendar.startOfDay(for: .now)

        let daySet = Set(completionDays)
        while daySet.contains(currentDay) {
            streak += 1
            guard let previous = calendar.date(byAdding: .day, value: -1, to: currentDay) else { break }
            currentDay = previous
        }

        return streak
    }

    private var longestStreak: Int {
        let calendar = Calendar.current
        let ascending = completionDays.sorted()
        guard !ascending.isEmpty else { return 0 }

        var best = 1
        var current = 1

        for index in 1..<ascending.count {
            let previous = ascending[index - 1]
            let day = ascending[index]

            if let expected = calendar.date(byAdding: .day, value: 1, to: previous),
               calendar.isDate(expected, inSameDayAs: day) {
                current += 1
            } else {
                best = max(best, current)
                current = 1
            }
        }

        return max(best, current)
    }

    var body: some View {
        ZStack {
            AppBackground()

            VStack(alignment: .leading, spacing: 16) {
                Text("Analytics")
                    .font(.system(size: 34, weight: .bold))

                LazyVGrid(columns: columns, spacing: 12) {
                    metricCard(
                        title: "Current Streak",
                        value: "\(currentStreak)",
                        icon: "flame.fill",
                        tint: .orange
                    )

                    metricCard(
                        title: "Tasks Completed",
                        value: "\(completedTasks.count)",
                        icon: "checkmark.seal.fill",
                        tint: .purple
                    )

                    metricCard(
                        title: "Avg Reduction",
                        value: String(format: "%.1f", averageReduction),
                        icon: "arrow.down.circle.fill",
                        tint: .purple
                    )

                    metricCard(
                        title: "Longest Streak",
                        value: "\(longestStreak)",
                        icon: "bolt.fill",
                        tint: .yellow
                    )

                    metricCard(
                        title: "Total Impact",
                        value: "\(totalImpact)",
                        icon: "chart.bar.fill",
                        tint: .green
                    )
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

    private func metricCard(title: String, value: String, icon: String, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(tint)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Text(value)
                .font(.title2.weight(.bold))
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(16)
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
