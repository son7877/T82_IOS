import Foundation
import CoreMotion
import Combine

class PedometerEventViewModel: ObservableObject {
    
    @Published var stepCount: Int = 0
    @Published var weeklyStepCount = WeeklyStepCount()
    private var pedometer = CMPedometer()
    private var cancellables = Set<AnyCancellable>()
    @Published var stepGoal = 30

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
    
    // 매일 자정에 걸음 수 초기화
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

    // 목표 달성 여부 확인
    func checkStepGoalAchieved() -> Bool {
        return stepCount >= stepGoal
    }

    func claimCoupon() {
        if checkStepGoalAchieved() {
            CouponService.shared.getPedometerCoupons { result in
                switch result {
                case .success(let coupons):
                    if let coupon = coupons.first {
                        CouponService.shared.issueEventCoupon(couponId: coupon.id) { result in
                            switch result {
                            case .success:
                                print("쿠폰 발급 성공")
                            case .failure(let error):
                                print("쿠폰 발급 실패: \(error.localizedDescription)")
                            }
                        }
                    }
                case .failure(let error):
                    print("쿠폰 조회 실패: \(error.localizedDescription)")
                }
            }
        }
    }
}
