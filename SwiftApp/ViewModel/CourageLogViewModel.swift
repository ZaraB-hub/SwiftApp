import Foundation

@Observable
final class CourageLogViewModel {

    let taskService: TaskServices
    var tasks: [Task] = []

    init(taskService: TaskServices) {
        self.taskService = taskService
    }

    func load() {
        tasks = taskService.getTasks()
    }

    func delete(id: UUID) {
        taskService.deleteTask(id: id)
        load()
    }
}