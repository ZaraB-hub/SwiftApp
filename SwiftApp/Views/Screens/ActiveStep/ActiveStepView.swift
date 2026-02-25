import SwiftUI
import Foundation

struct ActiveStepView: View {

    @State var viewModel: ActiveStepViewModel
    var onFlowFinished: (() -> Void)? = nil

    var body: some View {
        ZStack {
            AppBackground()

            if viewModel.taskSaved {
                SavedView(viewModel: viewModel) {
                    onFlowFinished?()
                }
            } else if viewModel.showReflection {
                ReflectionView(viewModel: viewModel)
            } else if viewModel.isCompleted {
                CompletedView(viewModel: viewModel)
            } else if viewModel.isBreathing {
                BreathingView(viewModel: viewModel)
            } else {
                StepView(viewModel: viewModel)
            }
        }
    }
}
