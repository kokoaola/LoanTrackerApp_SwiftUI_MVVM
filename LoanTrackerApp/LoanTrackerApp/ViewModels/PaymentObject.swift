//
//  PaymentObject.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/26.
//

import Foundation


///支払いに関する情報の型
struct PaymentObject: Equatable {
    var sectionName: String
    var sectionObjects: [Payment]
    //支払い合計額
    var sectionTotal: Double
}

