//
//  Countries.swift
//  Pandemic2020
//
//  Created by Shilpa S on 04/12/20.
//  Copyright © 2020 Shilpa S. All rights reserved.
//

import Foundation


class Country: Decodable {
    
    var country : String = ""
    var iso : String = ""
    var slug : String = ""
    
    enum CodingKeys : String, CodingKey {
        case country = "Country"
        case iso = "ISO2"
        case slug = "Slug"
    }
}
