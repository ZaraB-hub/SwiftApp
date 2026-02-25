import Foundation

@Observable
final class CourageLogViewModel {

    let taskService: TaskServices
    var tasks: [Task] = []

    var entryCount: Int {
        tasks.count
    }

    var totalCompletedTasks: Int {
        tasks.count
    }

    var averageReduction: Double {
        let reductions = tasks.compactMap { $0.anxietyReduction }
        guard !reductions.isEmpty else { return 0 }
        let total = reductions.reduce(0, +)
        return Double(total) / Double(reductions.count)
    }

    init(taskService: TaskServices) {
        self.taskService = taskService
    }

    func load() {
        tasks = taskService.getTasks()
            .filter { $0.status == .completed }
            .sorted { lhs, rhs in
                (lhs.dateCompleted ?? lhs.dateCreated) > (rhs.dateCompleted ?? rhs.dateCreated)
            }
    }

    func delete(id: UUID) {
        taskService.deleteTask(id: id)
        load()
    }
}

extension CourageLogViewModel {

    static var preview: CourageLogViewModel {

        let repo = SwiftDataTaskRepository(inMemoryOnly: true)

        let taskService = TaskServices(
            repository: repo,
            stepGenerator: StepGeneratorService()
        )

        return CourageLogViewModel(taskService: taskService)
    }
}