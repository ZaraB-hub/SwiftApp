import SwiftUI

struct CourageLogView: View {

    @State var viewModel: CourageLogViewModel

    var body: some View {
        List {
            ForEach(viewModel.tasks) { task in
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .font(.headline)

                    Text("Anxiety before: \(task.anxietyBefore)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            // .onDelete { indexSet in
            //     for index in indexSet {
            //         let task = viewModel.tasks[index]
            //         viewModel.delete(id: task.id)
            //     }
            // }
        }
        .navigationTitle("Courage Log")
        .onAppear {
            viewModel.load()
        }
    }
}
// //
// //  CourageLogView.swift
// //  SwiftApp
// //
// //  Created by Zara Bahtanović on 22. 2. 26.
// //


// import SwiftUI

// struct CourageLogView: View {

//     let taskService: TaskServices

//     @State private var tasks: [Task] = []

//     var body: some View {
//         List(tasks) { task in
//             VStack(alignment: .leading, spacing: 4) {
//                 Text(task.title)
//                     .font(.headline)

//                 Text("Anxiety before: \(task.anxietyBefore)")
//                     .font(.caption)
//                     .foregroundColor(.secondary)
//             }
//         }
//         .navigationTitle("Courage Log")
//         .onAppear {
//             tasks = taskService.getTasks()
//         }
//     }
// }

// #Preview {
//     let repo = SwiftDataTaskRepository(inMemoryOnly: true)
//     let generator = StepGeneratorService()
//     let service = TaskServices(repository: repo, stepGenerator: generator)

//     CourageLogView(taskService: service)
// }
