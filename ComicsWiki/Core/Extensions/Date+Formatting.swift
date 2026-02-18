//
//  Date+Formatting.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 18.02.2026.
//

import Foundation

extension Date {
    func string(_ format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = .current
        return formatter.string(from: self)
    }
}
