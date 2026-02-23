//
//  HomeView.swift
//  SwiftApp
//
//  Created by Zara Bahtanović on 22. 2. 26.
//

import SwiftUI

struct HomeView: View {
    
    @State var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {

            // LinearGradient(
            //     colors: [
            //         Color(.systemPurple).opacity(0.15),
            //         Color(.systemMint).opacity(0.25)
            //     ],
            //     startPoint: .topLeading,
            //     endPoint: .bottomTrailing
            // )
            // .ignoresSafeArea()

            AppBackground()

            VStack(spacing: 32) {

                Spacer()

                VStack(spacing: 12) {

                    Image(systemName: "exclamationmark.circle")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)

                    Text("Breathe.\nLet's begin.")
                        .font(.system(size: 34, weight: .bold))
                        .multilineTextAlignment(.center)

                    Text("Small steps turn mountains into gentle paths.")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                NavigationLink {
                    CreateTaskNameView(viewModel: AddTaskViewModel(taskService: viewModel.taskService, stepService: viewModel.stepService))
                } label: {
                    HStack {
                        Text("Start something hard")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                }

                NavigationLink {
                    CourageLogView(viewModel: CourageLogViewModel(taskService: viewModel.taskService)
    )
                } label: {
                    HStack {
                        Image(systemName: "book")
                        Text("Courage Log")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                }

                Spacer()
            }
            .padding()
        }
        .onAppear { viewModel.loadTasks() }
    }
}

