//
//  Date+Formatting.swift
//  KiwiApp
//
//  Created by Branko Ivandekic on 6/8/21.
//

import Foundation

extension Date {
    var displayTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: self)
    }

    var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, d MMM"
        return formatter.string(from: self)
    }
}
