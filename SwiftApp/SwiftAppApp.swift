//
//  SwiftAppApp.swift
//  SwiftApp
//
//  Created by Zara Bahtanović on 22. 2. 26.
//

import SwiftUI
import SwiftData


@main	
struct SwiftAppApp: App {
    private let sharedModelContainer: ModelContainer
    private let repository: SwiftDataTaskRepository
    private let stepGenerator:StepGeneratorService
    private let taskService:TaskServices
    private let stepService:StepService
    
    init(){
        let container = try! ModelContainer(for: Task.self)
        let repo = SwiftDataTaskRepository(modelContext: container.mainContext)
        let stepGen=StepGeneratorService()

        self.sharedModelContainer = container
        self.repository=repo
        self.stepGenerator=stepGen
        self.taskService = TaskServices(repository: repo, stepGenerator: stepGen)
        self.stepService = StepService(repository: repo)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(viewModel: HomeViewModel( taskService: taskService, stepService: stepService))
            }
        }
        .modelContainer(sharedModelContainer)
    }}
