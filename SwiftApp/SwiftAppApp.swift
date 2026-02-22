//
//  SwiftAppApp.swift
//  SwiftApp
//
//  Created by Zlatan Bahtanović on 22. 2. 26.
//

import SwiftUI

@main	
struct SwiftAppApp: App {
    private let repository:InMemoryTaskRepository
    private let stepGenerator:StepGeneratorService
    private let taskService:TaskServices
    private let stepService:StepService
    
    init(){
        let repo=InMemoryTaskRepository()
        let stepGen=StepGeneratorService()
        
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
    }}
