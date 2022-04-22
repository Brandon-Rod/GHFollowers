//
//  Date+ext.swift
//  GHFollowers
//
//  Created by Brandon Rodriguez on 3/10/22.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        
        return formatted(.dateTime.month().year())
        
    }
    
}
