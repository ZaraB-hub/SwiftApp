//
//  InsightService.swift
//  SwiftApp
//
//  Created by Zlatan Bahtanović on 22. 2. 26.
//


import Foundation

public final class InsightService {
    
    private let repository: TaskRepository
    
    public init(repository: TaskRepository) {
        self.repository = repository
    }
    
    // average anxiety reduction across all completed tasks
    public func averageAnxietyReduction() -> Double? {
        let completed = repository.fetchCompleted()
        let reductions = completed.compactMap { $0.anxietyReduction }
        guard !reductions.isEmpty else { return nil }
        return Double(reductions.reduce(0, +)) / Double(reductions.count)
    }
    
    // total steps completed across everything
    public func totalStepsCompleted() -> Int {
        repository.fetchCompleted()
            .flatMap { $0.steps }
            .filter { $0.isCompleted }
            .count
    }
    
    // total tasks completed
    public func totalTasksCompleted() -> Int {
        repository.fetchCompleted().count
    }
    
    // hardest task ever attempted (highest anxietyBefore)
    public func hardestTaskCompleted() -> Task? {
        repository.fetchCompleted()
            .max(by: { $0.anxietyBefore < $1.anxietyBefore })
    }
    
    // best task — biggest anxiety reduction
    public func bestTask() -> Task? {
        repository.fetchCompleted()
            .compactMap { task -> (Task, Int)? in
                guard let reduction = task.anxietyReduction else { return nil }
                return (task, reduction)
            }
            .max(by: { $0.1 < $1.1 })?
            .0
    }
    
    // most productive day of the week
    public func mostProductiveDay() -> String? {
        let completed = repository.fetchCompleted()
        guard !completed.isEmpty else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        
        var dayCounts: [String: Int] = [:]
        for task in completed {
            guard let date = task.dateCompleted else { continue }
            let day = formatter.string(from: date)
            dayCounts[day, default: 0] += 1
        }
        
        return dayCounts.max(by: { $0.value < $1.value })?.key
    }
}
