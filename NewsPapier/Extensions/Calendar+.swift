//
//  Calendar+.swift
//  NewsPapier
//
//  Created by Abdurrahman Gazi Yavuz on 1/28/23.
//

import Foundation

extension Calendar{
    
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Double {
        
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return Double(numberOfDays.day!)
    }
    
}
