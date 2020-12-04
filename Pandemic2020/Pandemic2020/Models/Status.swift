//
//  Status.swift
//  Pandemic2020
//
//  Created by Shilpa S on 04/12/20.
//  Copyright © 2020 Shilpa S. All rights reserved.
//

import Foundation


class Status : Decodable {
    var active : UInt64 = 0
    var confirmed : UInt64 = 0
    var recovered : UInt64 = 0
    var deaths : UInt64 = 0
    var date : String
    var country : String
    
    private enum CodingKeys : String, CodingKey {
        case active = "Active"
        case confirmed = "Confirmed"
        case recovered = "Recovered"
        case deaths = "Deaths"
        case date = "Date"
        case country = "Country"
    }
    
}
