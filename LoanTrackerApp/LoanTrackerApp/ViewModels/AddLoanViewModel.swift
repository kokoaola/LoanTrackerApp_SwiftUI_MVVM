//
//  AddLoanViewModel.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/25.
//

import SwiftUI

final class AddLoanViewModel: ObservableObject {
    @Published var name = ""
    @Published var amount = ""
    @Published var startDate = Date()
    @Published var dueDate = Date()
    
//    var isAddLoanShowing: Binding<Bool>

//    init(isAddLoanShowing: Binding<Bool>) {
//        self.isAddLoanShowing = isAddLoanShowing
//    }
    
    // 新しいローンを作成して保存
    func saveLoan() {
        let newLoan = Loan(context: PersistenceController.shared.viewContext)
        newLoan.id = UUID().uuidString
        newLoan.name = name
        newLoan.totalAmount = Double(amount) ?? 0.0
        newLoan.startDate = startDate
        newLoan.dueDate = dueDate
        // Core Dataに保存
        PersistenceController.shared.save()
    }
    
    // フォームの入力が有効かどうかをチェック
    func isInvalidForm() -> Bool {
        return name.isEmpty || amount.isEmpty
    }
}
