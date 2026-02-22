//
//  StepService.swift
//  SwiftApp
//
//  Created by Zlatan Bahtanović on 22. 2. 26.
//


import Foundation

public final class StepService {
    
    private let repository: TaskRepository
    
    public init(repository: TaskRepository) {
        self.repository = repository
    }
    
    public func firstUncompletedStep(in task: Task) -> Step? {
        task.steps.first { !$0.isCompleted }
    }
    
    public func completeStep(id: UUID, in task: Task) {
        var updatedTask = task
        guard let index = updatedTask.steps.firstIndex(where: { $0.id == id }) else { return }
        updatedTask.steps[index].isCompleted = true
        repository.update(updatedTask)
    }
}
