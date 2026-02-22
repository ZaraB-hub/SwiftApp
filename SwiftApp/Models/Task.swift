//
//  Task.swift
//  SwiftApp
//
//  Created by Zara Bahtanović on 22. 2. 26.
//

import Foundation

public struct Task: Identifiable {
    public var id = UUID()
    public var title: String
    public var steps: [Step]
    public var anxietyBefore: Int
    public var anxietyAfter: Int?
    public var reflection: String?
    public let dateCreated = Date()
    public var dateCompleted: Date?

    public init(title: String, steps: [Step], anxietyBefore: Int) {
        self.title = title
        self.steps = steps
        self.anxietyBefore = anxietyBefore
    }

    public var isCompleted: Bool {
        steps.allSatisfy { $0.isCompleted }
    }

    public var anxietyReduction: Int? {
        guard let after = anxietyAfter else { return nil }
        return anxietyBefore - after
    }

    public var status: TaskStatus {
        if isCompleted { return .completed }
        return .inProgress
    }
}

public enum TaskStatus {
    case inProgress
    case completed
}
