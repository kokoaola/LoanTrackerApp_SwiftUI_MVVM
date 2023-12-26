//
//  PaymentsView.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/25.
//

import SwiftUI

struct PaymentsView: View {
    
    @StateObject private var viewModel = PaymentViewModel()
    
    var loan: Loan
    
    @ViewBuilder private func addButton() -> some View{
        ///Destination.addPaymentを渡しているので、AddPaymentViewへ自動で遷移する
        NavigationLink(value: Destination.addPayment(loan)){
            Image(systemName: "plus.circle")
                .font(.title3)
                .padding([.vertical, .leading], 5)
        }
    }
    
    @ViewBuilder private func progressView() -> some View{
        VStack{
            Text("Payment Progress")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top)
            ProgressBar(progress: viewModel.progress)
                .padding(.horizontal)
            Text(viewModel.expectedToFinishOn)
        }
    }
    
    var body: some View {
        VStack{
            progressView()
            
            List {
                ForEach(viewModel.allPaymentObject, id: \.sectionName) { paymentObject in
                    
                    Section(header: Text("\(paymentObject.sectionName) - \(paymentObject.sectionTotal, format: .currency(code: "JPY"))")) {
                        
                        ForEach(paymentObject.sectionObjects) { payment in
                            NavigationLink(value: Destination.addPayment(loan, payment))
                            {
                                PaymentCell(amount: payment.amount, date: payment.wrappedDate)
                            }
                        }
                        .onDelete { index in
                            viewModel.deleteItem(paymentObject: paymentObject, index: index)
                        }
                    }
                }
            }
            .listStyle(.grouped)
        }
        .navigationTitle(loan.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                addButton()
            }
        }
        .onAppear{
            viewModel.setLoanObject(loan: loan)
            viewModel.calculateProgress()
            viewModel.calculateDays()
            viewModel.separateByYear()
        }
    }
}

