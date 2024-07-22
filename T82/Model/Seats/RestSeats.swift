import Foundation

struct RestSeats: Decodable, Hashable{
    let sectionId : Int
    let name : String
    let restSeat : Int
}
