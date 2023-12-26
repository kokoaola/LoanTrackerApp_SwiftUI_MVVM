//
//  AddLoanView.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/25.
//

import SwiftUI

struct AddLoanView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AddLoanViewModel()
    
    @ViewBuilder
    private func cancelButton() -> some View{
        Button {
            dismiss()
        } label: {
            Text("Cancel")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
    
    @ViewBuilder
    private func saveButton() -> some View{
        Button {
            viewModel.saveLoan()
            print("OK")
            dismiss()
        } label: {
            Text("Done")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        //.isInvalidFormがtrueで、disabledもtrueになる
        .disabled(viewModel.isInvalidForm())
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                Form {
                    TextField("Name", text: $viewModel.name)
                    ///何かを入力すると、文の最初の文字が自動的に大文字になる
                        .autocapitalization(.sentences)
                    TextField("Amount", text: $viewModel.amount)
                        .keyboardType(.numberPad)
                    
                    
                    ///開始日の範囲として、今日までの任意の日付を選択
                    ///右の日付から左の日付までの範囲
                    ///現在の日付より前なら全て選択可なら...Date()
                    ///displayedComponentsを.dateで時間を削除
                    DatePicker("Start Date", selection: $viewModel.startDate, in: ...Date(), displayedComponents: .date)
                    
                    ///開始日の範囲として、今日までの任意の日付を選択現在の日付より前全て可なら...Date()
                    ///現在の日付より未来なら全て選択可ならstartDate...
                    DatePicker("Due Date", selection: $viewModel.dueDate, in: viewModel.startDate..., displayedComponents: .date)
                }
            }
            .toolbar {
                //場所をデフォルトのキャンセルボタンの位置にする
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton()
                }
                ToolbarItem(placement: .confirmationAction) {
                    saveButton()
                }
            }
        }
    }
}

struct AddLoanView_Previews: PreviewProvider {
    static var previews: some View {
        AddLoanView()
    }
}
