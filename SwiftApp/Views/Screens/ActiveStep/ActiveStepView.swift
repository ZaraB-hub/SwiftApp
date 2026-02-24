import SwiftUI
import Foundation

struct ActiveStepView: View {

    @State var viewModel: ActiveStepViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            AppBackground()

            if viewModel.taskSaved {
                SavedView(viewModel: viewModel, dismiss: dismiss)
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
