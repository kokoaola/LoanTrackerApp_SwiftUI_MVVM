//
//  Destination.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/25.
//

import Foundation

///遷移先を指定する列挙型
enum Destination: Hashable{
    case payment(Loan)
    case addPayment(Loan, Payment? = nil)
}
