import Foundation
import CoreMotion
import Combine

class PedometerEventViewModel: ObservableObject {
    
    @Published var stepCount: Int = 0
    @Published var stepGoal: Int = 30
    @Published var hasClaimedCoupon: Bool = false

    private var pedometer = CMPedometer()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadStepCount()  
        startPedometer()
        setupDailyReset()
    }

    func loadStepCount() {
        stepCount = UserDefaults.standard.integer(forKey: "StepCount")
        hasClaimedCoupon = UserDefaults.standard.bool(forKey: "HasClaimedCoupon")
    }

    private func saveStepCount() {
        UserDefaults.standard.set(stepCount, forKey: "StepCount")
    }

    private func saveCouponClaimedStatus() {
        UserDefaults.standard.set(hasClaimedCoupon, forKey: "HasClaimedCoupon")
    }

    private func startPedometer() {
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { [weak self] data, error in
                guard let self = self, error == nil, let data = data else { return }
                DispatchQueue.main.async {
                    self.stepCount = data.numberOfSteps.intValue
                    self.saveStepCount()
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
        stepCount = 0
        hasClaimedCoupon = false
        saveStepCount()
        saveCouponClaimedStatus()
        pedometer.stopUpdates()
        startPedometer()
    }

    func checkStepGoalAchieved() -> Bool {
        return stepCount >= stepGoal
    }

    func claimCoupon() {
        guard checkStepGoalAchieved(), !hasClaimedCoupon else { return }

        CouponService.shared.getPedometerCoupons { result in
            switch result {
            case .success(let coupons):
                if let coupon = coupons.first {
                    CouponService.shared.issueEventCoupon(couponId: coupon.id) { result in
                        switch result {
                        case .success:
                            self.hasClaimedCoupon = true
                            self.saveCouponClaimedStatus() // 상태 저장
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
