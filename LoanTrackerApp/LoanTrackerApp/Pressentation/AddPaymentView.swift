//
//  AddPaymentView.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/25.
//

import SwiftUI

struct AddPaymentView: View {
    @StateObject var viewModel = AddPaymentViewModel()
    @Environment(\.dismiss) var dismiss
    
    var loan: Loan
    var payment: Payment?
    
    @ViewBuilder
    private func saveButton() -> some View{
        Button {
            viewModel.savePayment()
            dismiss()
        } label: {
            Text("Done")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .disabled(viewModel.isInvalidForm())
    }
    
    var body: some View {
            List {
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.numberPad)
                
                DatePicker("Date", selection: $viewModel.date, in: Date()..., displayedComponents: .date)
            }
            .navigationTitle(payment != nil ? "Edit Payment" : "Add Payment")
            .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                saveButton()
            }
        }
        .onAppear{
            //ローンオブジェクトを設定する関数をビューモデルに作成
            viewModel.setLoanObject(loan: loan)
            viewModel.setPaymentObject(payment: payment)
            viewModel.setupEditView()
        }
    }
}

//struct AddPaymentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPaymentView()
//    }
//}
