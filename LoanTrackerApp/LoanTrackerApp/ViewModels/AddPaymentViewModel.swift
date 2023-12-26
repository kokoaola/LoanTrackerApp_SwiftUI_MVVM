//
//  AddPaymentViewModel.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/25.
//

import Foundation


final class AddPaymentViewModel: ObservableObject{
    @Published var amount = ""
    @Published var date = Date()
    private var loan: Loan?
    private var payment: Payment?
    
    func setLoanObject(loan: Loan){
        self.loan = loan
    }
    
    func setPaymentObject(payment: Payment?){
        self.payment = payment
    }
    
    func savePayment() {
        payment != nil ? updatePayment() : createNewPayment()
//        createNewPayment()
//        if payment != nil {
//            updatePayment()
//        } else {
//            createNewPayment()
//        }
    }
    
    func createNewPayment() {
        let newPayment = Payment(context: PersistenceController.shared.viewContext)
        newPayment.id = UUID().uuidString
        newPayment.amount = Double(amount) ?? 0.0
        newPayment.date = date
//        newPayment.loanId = loanId
        newPayment.loan = loan
        
        PersistenceController.shared.save()
    }
    
    func updatePayment() {
        guard let payment = payment else { return }
        payment.amount = Double(amount) ?? 0.0
        payment.date = date
        
        PersistenceController.shared.save()
    }
    
    func setupEditView(){
        guard let payment = payment else { return }
        
        amount = "\(payment.amount)"
        date = payment.wrappedDate
    }
    
    
    func isInvalidForm() -> Bool {
        return amount.isEmpty
    }
}
