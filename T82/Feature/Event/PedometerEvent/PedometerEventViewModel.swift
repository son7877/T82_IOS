import Foundation
import CoreMotion
import Combine

class PedometerEventViewModel: ObservableObject {
    @Published var stepCount: Int = 0
    @Published var weeklyStepCount = WeeklyStepCount()
    private var pedometer = CMPedometer()
    private var cancellables = Set<AnyCancellable>()
    @Published var stepGoal = 10000

    init() {
        startPedometer()
        setupDailyReset()
    }

    private func startPedometer() {
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { [weak self] data, error in
                guard let self = self, error == nil, let data = data else { return }
                DispatchQueue.main.async {
                    self.stepCount = data.numberOfSteps.intValue
                }
            }
        }
    }

    private func setupDailyReset() {
        let calendar = Calendar.current
        let midnight = calendar.startOfDay(for: Date())
        let nextMidnight = calendar.date(byAdding: .day, value: 1, to: midnight)!

        Timer.publish(every: nextMidnight.timeIntervalSinceNow, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.resetStepCount()
                self?.setupDailyReset()
            }
            .store(in: &cancellables)
    }

    private func resetStepCount() {
        let todayStepCount = StepCount(date: Date(), steps: stepCount)
        weeklyStepCount.addStepCount(todayStepCount)
        stepCount = 0
        pedometer.stopUpdates()
        startPedometer()
    }

    func checkStepGoalAchieved() -> Bool {
        return stepCount >= stepGoal
    }

    func claimCoupon() {
        if checkStepGoalAchieved() {
            // 쿠폰 지급 로직 (예: 서버에 쿠폰 요청 등)
            print("쿠폰이 지급되었습니다!")
        }
    }
}
