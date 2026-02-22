//
//  ActiveStepViewModel.swift
//  SwiftApp
//
//  Created by Zlatan Bahtanović on 22. 2. 26.
//


import Foundation

@Observable
public final class ActiveStepViewModel {
    
     let stepService: StepService
     let taskService: TaskServices
    
    var task: Task
    var currentStep: Step? = nil
    var isBreathing: Bool = false
    var isCompleted: Bool = false
    var showReflection: Bool = false
    var anxietyAfter: Double = 5
    var reflection: String = ""
    var taskSaved: Bool = false
    
    init(task: Task, stepService: StepService, taskService: TaskServices) {
        self.task = task
        self.stepService = stepService
        self.taskService = taskService
        self.currentStep = stepService.firstUncompletedStep(in: task)
    }
    
    func completeCurrentStep() {
        guard let step = currentStep else { return }
        
        stepService.completeStep(id: step.id, in: task)
        
        task.steps = task.steps.map { s in
            var updated = s
            if s.id == step.id { updated.isCompleted = true }
            return updated
        }
        
        currentStep = stepService.firstUncompletedStep(in: task)
        
        if currentStep == nil {
            isCompleted = true
        }
    }
    
    func tooHard() {
        isBreathing = true
        runBreathing()
    }
    
    func saveAndFinish() {
        try? taskService.completeTask(
            id: task.id,
            anxietyAfter: Int(anxietyAfter),
            reflection: reflection.isEmpty ? nil : reflection
        )
        taskSaved = true
    }
    
    private func runBreathing() {
        let phases: [(String, Double, TimeInterval)] = [
            ("Inhale", 0.33, 4),
            ("Hold", 0.66, 4),
            ("Exhale", 1.0, 6)
        ]
        
        var delay: TimeInterval = 0
        
        for (phase, progress, duration) in phases {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.breathingPhase = phase
                self.breathingProgress = progress
            }
            delay += duration
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.isBreathing = false
            self.breathingPhase = "Inhale"
            self.breathingProgress = 0.0
        }
    }
    
    var breathingPhase: String = "Inhale"
    var breathingProgress: Double = 0.0
}
