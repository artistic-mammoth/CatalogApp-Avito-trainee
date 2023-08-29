//
//  Date+initFromString.swift
//  CatalogApp
//
//  Created by Михайлов Александр on 28.08.2023.
//

import Foundation

extension Date {
    init?(_ string: String, format: String = "yyyy-MM-dd") {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.default
        formatter.dateFormat = format
        
        if let date = formatter.date(from: string) {
            self.init(timeInterval: 0, since: date)
        } else {
            return nil
        }
    }
}
