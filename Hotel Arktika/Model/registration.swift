//
//  registration.swift
//  Hotel Arktika
//
//  Created by Aleksey Popov on 25/09/2019.
//  Copyright © 2019 Aleksey Popov. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate :Date
    var checkOutDate: Date
    var numberOfAdults : Int
    var numberOfChildren: Int
    
    var roomType : RoomeType
    var wifi: Bool
}

struct RoomeType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var prices: Int
    
    static func == (lhs: RoomeType, rhs: RoomeType) -> Bool {
        return lhs.id == rhs.id
    }
}
