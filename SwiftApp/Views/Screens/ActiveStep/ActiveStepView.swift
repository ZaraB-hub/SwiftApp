
import SwiftUI
import Foundation
import UIKit

struct ActiveStepView: View {

    @State var viewModel: ActiveStepViewModel
    var onFlowFinished: (() -> Void)? = nil
    @Environment(\.dismiss) private var dismiss

    private var shouldLockBackNavigation: Bool {
        viewModel.isBreathing || viewModel.showReflection || viewModel.isCompleted || isShowingStepView
    }

    private var isShowingStepView: Bool {
        !viewModel.taskSaved && !viewModel.showReflection && !viewModel.isCompleted && !viewModel.isBreathing
    }

    var body: some View {
        ZStack {
            AppBackground()

            if viewModel.taskSaved {
                SavedView(viewModel: viewModel){
                    if let onFlowFinished {
                        onFlowFinished()
                    } else {
                        dismiss()
                    }
                }
            } else if viewModel.showReflection {
                ReflectionView(viewModel: viewModel)
            } else if viewModel.isCompleted {
                CompletedView(viewModel: viewModel)
            } else if viewModel.isBreathing {
                BreathingView(viewModel: viewModel)
            } else {
                StepView(viewModel: viewModel) {
                    if let onFlowFinished {
                        onFlowFinished()
                    } else {
                        dismiss()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(shouldLockBackNavigation)
        .background(
            BackNavigationControllerLock(isLocked: shouldLockBackNavigation)
        )
        .onDisappear {
            guard isShowingStepView else { return }
            onFlowFinished?()
        }
    }
}

private struct BackNavigationControllerLock: UIViewControllerRepresentable {

    let isLocked: Bool

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard let navigationController = uiViewController.navigationController else { return }
        navigationController.interactivePopGestureRecognizer?.isEnabled = !isLocked
    }
}
