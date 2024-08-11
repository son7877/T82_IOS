import SwiftUI

struct EventTabView: View {
    
    var selection : EventTabInfo
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            switch selection{
            case .firstCoupons:
                FirstEventCouponView(firstEventCouponviewModel: FirstEventCouponViewModel())
            case .pedometer:
                PedometerEventView(pedometerViewModel: PedometerEventViewModel())
            }
        }
    }
}

