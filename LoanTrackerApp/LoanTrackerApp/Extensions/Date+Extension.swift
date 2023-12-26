//
//  Date+Extension.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/26.
//

import Foundation

///年号だけを取得する拡張機能
extension Date {
    var intOfYear: Int? {
        return Calendar.current.dateComponents([.year], from: self).year
    }
}
