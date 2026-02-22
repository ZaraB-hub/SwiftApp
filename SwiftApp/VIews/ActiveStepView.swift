//
//  ActiveStepView.swift
//  SwiftApp
//
//  Created by Zlatan Bahtanović on 22. 2. 26.
//


import SwiftUI

struct ActiveStepView: View {
    
    @State var viewModel: ActiveStepViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(.systemPurple).opacity(0.15),
                    Color(.systemMint).opacity(0.25)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            if viewModel.taskSaved {
                savedView
            } else if viewModel.showReflection {
                reflectionView
            } else if viewModel.isCompleted {
                completedView
            } else if viewModel.isBreathing {
                breathingView
            } else {
                stepView
            }
        }
        .navigationBarBackButtonHidden(true)
        .animation(.easeInOut, value: viewModel.isBreathing)
        .animation(.easeInOut, value: viewModel.isCompleted)
        .animation(.easeInOut, value: viewModel.showReflection)
        .animation(.easeInOut, value: viewModel.taskSaved)
    }
    
    // MARK: - Step View
    var stepView: some View {
        VStack(spacing: 40) {
            Spacer()
            
            VStack(spacing: 8) {
                Text("One small step")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                let completed = viewModel.task.steps.filter { $0.isCompleted }.count
                let total = viewModel.task.steps.count
                
                Text("\(completed) of \(total)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                ProgressView(value: Double(completed), total: Double(total))
                    .tint(.purple)
                    .padding(.horizontal, 40)
            }
            
            if let step = viewModel.currentStep {
                Text(step.title)
                    .font(.system(size: 26, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Spacer()
            
            VStack(spacing: 12) {
                Button {
                    viewModel.completeCurrentStep()
                } label: {
                    Text("Done ✓")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
                
                Button {
                    viewModel.tooHard()
                } label: {
                    Text("Too hard right now")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .foregroundColor(.black)
                        .cornerRadius(16)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
    }
    
    // MARK: - Breathing View
    var breathingView: some View {
        VStack(spacing: 48) {
            Spacer()
            
            Text(viewModel.breathingPhase)
                .font(.system(size: 36, weight: .light))
            
            ZStack {
                Circle()
                    .stroke(Color.purple.opacity(0.15), lineWidth: 2)
                    .frame(width: 220, height: 220)
                
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Color.purple.opacity(0.3), Color.mint.opacity(0.2)],
                            center: .center,
                            startRadius: 0,
                            endRadius: 110
                        )
                    )
                    .frame(
                        width: 80 + (viewModel.breathingProgress * 140),
                        height: 80 + (viewModel.breathingProgress * 140)
                    )
                    .animation(.easeInOut(duration: 3), value: viewModel.breathingProgress)
            }
            
            Text("Breathe with me")
                .foregroundColor(.secondary)
                .font(.subheadline)
            
            Spacer()
        }
    }
    
    // MARK: - Completed View
    var completedView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Text("🎉")
                .font(.system(size: 80))
            
            Text("You did it.")
                .font(.system(size: 34, weight: .bold))
            
            Text("That took courage.")
                .foregroundColor(.secondary)
                .font(.title3)
            
            Spacer()
            
            Button {
                viewModel.showReflection = true
            } label: {
                Text("How do you feel now?")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
    }
    
    // MARK: - Reflection View
    var reflectionView: some View {
        VStack(spacing: 32) {
            Spacer()
            
            Text("How anxious do you feel now?")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            Text("\(Int(viewModel.anxietyAfter))")
                .font(.system(size: 72, weight: .bold))
                .foregroundColor(.purple.opacity(0.8))
            
            Text(anxietyLabel(for: Int(viewModel.anxietyAfter)))
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Slider(value: $viewModel.anxietyAfter, in: 1...10, step: 1)
                .tint(.purple)
                .padding(.horizontal)
            
            VStack(spacing: 8) {
                Text("Any reflection? (optional)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                TextField("It wasn't as bad as I thought...", text: $viewModel.reflection, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...5)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            Button {
                viewModel.saveAndFinish()
            } label: {
                Text("Save & Finish")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
        .padding()
    }
    
    // MARK: - Saved View
    var savedView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Text("✨")
                .font(.system(size: 80))
            
            Text("Saved to your Courage Log.")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            if let reduction = viewModel.task.anxietyReduction {
                Text("Your anxiety dropped \(reduction) points.")
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                // pop all the way back to home
                dismiss()
                dismiss()
                dismiss()
            } label: {
                Text("Back to Home")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
    }
    
    func anxietyLabel(for value: Int) -> String {
        switch value {
        case 1: return "Barely bothered"
        case 2: return "A little uneasy"
        case 3: return "Somewhat nervous"
        case 4: return "Noticeably anxious"
        case 5: return "Moderately stressed"
        case 6: return "Quite anxious"
        case 7: return "Very anxious"
        case 8: return "Really struggling"
        case 9: return "Extremely overwhelmed"
        case 10: return "Cannot function right now"
        default: return ""
        }
    }
}