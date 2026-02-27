
import SwiftUI

struct CourageLogView: View {

    @State var viewModel: CourageLogViewModel

    var body: some View {
        ZStack {
            AppBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Courage Log")
                        .font(.system(size: 34, weight: .bold))

                    Text("\(viewModel.entryCount) entries")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    VStack(spacing: 12) {
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Avg point reduction")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(String(format: "%.1f", viewModel.averageReduction))
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
                                Text("\(viewModel.totalCompletedTasks)")
                                    .font(.title2.weight(.bold))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.white.opacity(0.92))
                            .cornerRadius(16)
                        }

                        NavigationLink {
                            AnalyticsView(taskService: viewModel.taskService)
                        } label: {
                            SecondaryActionButtonLabel(title: "View Full Analytics")
                        }
                    }

                    if viewModel.tasks.isEmpty {
                        Text("No completed tasks yet.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.top, 8)
                    }

                    ForEach(viewModel.tasks) { task in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(task.title)
                                .font(.headline)

                            Text((task.dateCompleted ?? task.dateCreated).formatted(date: .abbreviated, time: .omitted))
                                .font(.caption)
                                .foregroundColor(.secondary)

                            HStack(spacing: 16) {
                                Text("Before: \(task.anxietyBefore)")
                                    .font(.subheadline)

                                Text("After: \(task.anxietyAfter.map(String.init) ?? "—")")
                                    .font(.subheadline)
                            }

                            if let reflection = task.reflection, !reflection.isEmpty {
                                Text(reflection)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white.opacity(0.92))
                        .cornerRadius(18)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 24)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.load()
        }
    }
}
