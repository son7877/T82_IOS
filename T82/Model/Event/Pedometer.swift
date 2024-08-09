import Foundation

struct StepCount: Identifiable {
    let id = UUID()
    let date: Date
    let steps: Int
}

struct WeeklyStepCount {
    var dailySteps: [StepCount] = []

    mutating func addStepCount(_ stepCount: StepCount) {
        dailySteps.append(stepCount)
        if dailySteps.count > 7 {
            dailySteps.removeFirst()
        }
    }

    func totalSteps() -> Int {
        return dailySteps.reduce(0) { $0 + $1.steps }
    }
}
