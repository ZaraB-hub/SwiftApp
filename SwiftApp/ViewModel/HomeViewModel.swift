//
//  HomeViewModel.swift
//  SwiftApp
//
//  Created by Zara Bahtanović on 22. 2. 26.
//


import Foundation

@Observable
public final class HomeViewModel {
    
    let taskService: TaskServices
    let stepService: StepService
    
    var activeTasks: [Task] = []
    var completedTasks: [Task] = []

    private let tasksPerGrowthStage = 3

    var completedCount: Int {
        completedTasks.count
    }

    var plantStageIndex: Int {
        min(completedCount / tasksPerGrowthStage, 4)
    }

    var plantEmoji: String {
        switch plantStageIndex {
        case 0: return "🌱"
        case 1: return "🌿"
        case 2: return "🪴"
        case 3: return "🌳"
        default: return "🌸"
        }
    }

    var plantStageTitle: String {
        switch plantStageIndex {
        case 0: return "Seedling"
        case 1: return "Sprout"
        case 2: return "Growing"
        case 3: return "Thriving"
        default: return "Blooming"
        }
    }

    var progressToNextPlantStage: Double {
        if plantStageIndex >= 4 { return 1 }
        let remainder = completedCount % tasksPerGrowthStage
        return Double(remainder) / Double(tasksPerGrowthStage)
    }

    var tasksToNextPlantStage: Int {
        if plantStageIndex >= 4 { return 0 }
        let remainder = completedCount % tasksPerGrowthStage
        return tasksPerGrowthStage - remainder
    }
    
    public init(taskService: TaskServices, stepService:StepService) {
        self.taskService = taskService
        self.stepService=stepService
    }
    
    func loadTasks() {
        let all = taskService.getTasks()
        activeTasks = all.filter { $0.status == .inProgress }
        completedTasks = all.filter { $0.status == .completed }
    }
    
    func deleteTask(id: UUID) {
        taskService.deleteTask(id: id)
        loadTasks()
    }
}
extension HomeViewModel {

    static var preview: HomeViewModel {

        let repo = SwiftDataTaskRepository(inMemoryOnly: true)

        let stepService = StepService(repository: repo)

        let taskService = TaskServices(
            repository: repo,
            stepGenerator: StepGeneratorService()
        )

        return HomeViewModel(
            taskService: taskService,
            stepService: stepService
        )
    }
}
