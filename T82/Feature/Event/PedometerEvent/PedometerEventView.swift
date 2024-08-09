import SwiftUI

struct PedometerEventView: View {
    
    @StateObject var pedometerViewModel : PedometerEventViewModel
    
    var body: some View {
        VStack {
            Text("오늘의 걸음 수")
                .font(.title2)
                .padding()
            
            HStack{
                Text("\(pedometerViewModel.stepCount)")
                    .font(.system(size: 64))
                    .padding(.vertical)
                
                Text("/   "+"\(pedometerViewModel.stepGoal)")
                    .font(.system(size: 24))
                    .padding()
            }
            
            Button(action: {
                pedometerViewModel.claimCoupon()
            }) {
                Text("쿠폰 받기")
                    .font(.title3)
                    .padding()
                    .background(pedometerViewModel.checkStepGoalAchieved() ? Color.customred : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(!pedometerViewModel.checkStepGoalAchieved())
            .padding()

            Divider()
                .padding()

//            Text("1주일 걸음 수 통계")
//                .font(.title)
//                .padding()
//
//            List(pedometerViewModel.weeklyStepCount.dailySteps) { stepCount in
//                HStack {
//                    Text(dateFormatter.string(from: stepCount.date))
//                    Spacer()
//                    Text("\(stepCount.steps) 걸음")
//                }
//            }
//
//            Spacer()
        }
        .padding()
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}

