//
//  PaymentViewModel.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/26.
//

import Foundation
import SwiftUI


final class PaymentViewModel: ObservableObject{
    @Published private(set) var expectedToFinishOn = ""
    @Published private(set) var progress = Progress()
    @Published private(set) var allPayments: [Payment] = []
    @Published private(set) var allPaymentObject: [PaymentObject] = []
    
    private var loan: Loan?
    
    func setLoanObject(loan: Loan){
        self.loan = loan
        setPayments()
    }
    
    private func setPayments(){
        guard let loan = loan else{ return }
        allPayments = loan.paymentArray
    }
    
    func calculateProgress(){
        guard let loan = loan else{ return }
        let totalPaid = allPayments.reduce(0){
            $0 + $1.amount
        }
        let totalLeft = loan.totalAmount - totalPaid
        let value = totalPaid / loan.totalAmount
        
        progress = Progress(value: value, leftAmount: totalLeft, paidAmount: totalPaid)
    }
    
    
    ///ローン期間を計算し、支払いが完了するまであと何日かかるか決めるビュー
    func calculateDays() {
        guard let loan = loan else { return }
        
        var paymentStatus = ""
        
        let totalPaid = allPayments.reduce(0) { $0 + $1.amount }
        
        //ローンの開始日からローンの期日までの日数を計算
        let totalDays = Calendar.current.dateComponents([.day], from: loan.wrappedStartDate, to: loan.wrappedDueDate).day!
        //ローンの開始日から何日経過したかを計算
        let passedDays = Calendar.current.dateComponents([.day], from: loan.wrappedStartDate, to: Date()).day!
        
        //過去の日数がゼロまたはローンが全て支払われた場合
        if passedDays == 0 || totalPaid == 0 {
            //終了予定なしで返す
            expectedToFinishOn = ""
            return
        }
        
        //１日あたりに支払った金額を計算
        let didPayPerDay = totalPaid / Double(passedDays)
        //１日あたりに支払うべきだった金額を計算
        let shouldPayPerDay = loan.totalAmount / Double(totalDays)
        
        //支払いが遅れているか、スケジュールよりも順調か表示
        paymentStatus = shouldPayPerDay > didPayPerDay ? "Behind the schedule" : "Ahead of schedule"
        
        //これから１日あたりいくら支払わなければならないか計算
        let daysLeftToFinish = (loan.totalAmount - totalPaid) / didPayPerDay
        //残りの日数を計算
        let newDate = Calendar.current.date(byAdding: .day, value: Int(daysLeftToFinish), to: Date())
        guard let newDate = newDate else {
            expectedToFinishOn = ""
            return
        }
        
        //現在のスケジュールだと、いつ支払いが終わるか表示
        expectedToFinishOn = "Expected to finish by \(newDate.formatted(date: .long, time: .omitted)) \n \(paymentStatus)"
    }
    
    
    
    
    ///削除用メソッド
    func deleteItem(paymentObject: PaymentObject, index: IndexSet){
        guard let index = index.first else { return }
        
        let paymentToDelete = paymentObject.sectionObjects[index]
        
        PersistenceController.shared.viewContext.delete(paymentToDelete)
        PersistenceController.shared.save()
        
        setPayments()
        withAnimation {
            calculateProgress()
            calculateDays()
        }
        separateByYear()
    }
    
    func separateByYear(){
        allPaymentObject = []
        //すべての支払いを年ごとに分ける
        //キーは年数、値は支払いの配列
        let dict = Dictionary(grouping: allPayments) { $0.wrappedDate.intOfYear }
        
        //その年の支払い総額を取得する
        for(key, value) in dict{
            guard let key = key else { return }
            let total = value.reduce(0){ $0 + $1.amount}
            
            allPaymentObject.append(PaymentObject(sectionName: "\(key)", sectionObjects: value.reversed(), sectionTotal: total))
        }
        //年数が新しいものから並べる
        allPaymentObject.sort { $0.sectionName > $1.sectionName }
    }
}
