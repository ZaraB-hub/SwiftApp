//
//  AddTaskViewModel.swift
//  SwiftApp
//
//  Created by Zara Bahtanović on 22. 2. 26.
//


import Foundation

@Observable
public final class AddTaskViewModel {
    
    let taskService: TaskServices
    let stepService: StepService
    
    var title: String = ""
    var anxiety: Double = 5
    var createdTask: Task? = nil
    var isLoading: Bool = false
    
    init(taskService: TaskServices, stepService: StepService) {
        self.taskService = taskService
        self.stepService = stepService
    }
    
    func createTask() async {
        isLoading = true
        await taskService.createTask(title: title, anxietyBefore: Int(anxiety))
        createdTask = taskService.getTasks().last
        isLoading = false
    }
}
