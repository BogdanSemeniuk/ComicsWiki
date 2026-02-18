//
//  DateFormat.swift
//  ComicsWiki
//
//  Created by Богдан Семенюк on 18.02.2026.
//

import Foundation

enum DateFormat: String {
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
    case short = "dd.MM.yyyy"
    case medium = "d MMM yyyy"
    case long = "d MMMM yyyy"
    case time = "HH:mm"
    case dateTime = "dd.MM.yyyy HH:mm"
}
