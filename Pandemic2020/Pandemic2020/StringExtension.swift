//
//  Date.swift
//  Pandemic2020
//
//  Created by Shilpa S on 04/12/20.
//  Copyright © 2020 Shilpa S. All rights reserved.
//

import Foundation

extension String {
    func formattedDateString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let date = dateFormatter.date(from: self)
        
        let displayFormatter = DateFormatter()
        displayFormatter.locale =  Locale.current
        displayFormatter.dateFormat = "MMMM, dd YYYY"
        displayFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return displayFormatter.string(from : date ?? Date())
    }
    
    func formatterNumberString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal
        numberFormatter.alwaysShowsDecimalSeparator = false
        let number = numberFormatter.number(from: self) ?? NSNumber()
        
//        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: number) ?? self
    }
}
