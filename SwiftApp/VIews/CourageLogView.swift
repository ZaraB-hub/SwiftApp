//
//  CourageLogView.swift
//  SwiftApp
//
//  Created by Zlatan Bahtanović on 22. 2. 26.
//


import SwiftUI

struct CourageLogView: View {

    let taskService: TaskServices

    @State private var tasks: [Task] = []

    var body: some View {
        List(tasks) { task in
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.headline)

                Text("Anxiety before: \(task.anxietyBefore)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Courage Log")
        .onAppear {
            tasks = taskService.getTasks()
        }
    }
}

#Preview {
    let repo = InMemoryTaskRepository()
    let generator = StepGeneratorService()
    let service = TaskServices(repository: repo, stepGenerator: generator)

    CourageLogView(taskService: service)
}
