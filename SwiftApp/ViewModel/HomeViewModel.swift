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
