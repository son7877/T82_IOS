import SwiftUI

struct PedometerEventView: View {
    
    @StateObject var pedometerViewModel: PedometerEventViewModel
    
    var body: some View {
        VStack {
            Text("오늘의 걸음 수")
                .font(.title2)
                .padding()
            
            HStack {
                Text("\(pedometerViewModel.stepCount)")
                    .font(.system(size: 64))
                    .padding(.vertical)
                
                Text("/   " + "\(pedometerViewModel.stepGoal)")
                    .font(.system(size: 24))
                    .padding()
            }
            
            Button(action: {
                pedometerViewModel.claimCoupon()
            }) {
                Text(pedometerViewModel.hasClaimedCoupon ? "쿠폰 발급 완료" : "쿠폰 받기")
                    .font(.title3)
                    .padding()
                    .background(pedometerViewModel.checkStepGoalAchieved() && !pedometerViewModel.hasClaimedCoupon ? Color.customred : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(!pedometerViewModel.checkStepGoalAchieved() || pedometerViewModel.hasClaimedCoupon)
            .padding()

            Divider()
                .padding()
        }
        .padding()
    }
}
