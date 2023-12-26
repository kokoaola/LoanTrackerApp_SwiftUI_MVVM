//
//  ContentView.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/25.
//

import SwiftUI
import CoreData

struct AllLoansView: View {
    @Environment(\.managedObjectContext) var veiwContext
    
    ///フェッチリクエストを作成
    ///日付順に並べ替え、コアデータで何かが変更されるたびに、テーブルにアニメーション化された挿入が行われる
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Loan.startDate, ascending: true)],
        animation: .default)
    private var loans: FetchedResults<Loan>
    
    ///AddLoanシートの表示用のフラグ
    @State var isAddLoanShowing = false
    
    @ViewBuilder private func addButton() -> some View{
        Button {
            isAddLoanShowing = true
        } label: {
            Image(systemName: "plus.circle")
                .font(.title3)
        }
        .padding([.vertical, .leading], 5)
    }

    var body: some View {
        NavigationStack {
            List{
                ForEach(loans){loan in
                    //valueで値を渡せる
                    //ナビゲーション ストックに、何らかのナビゲーションを受信するたびに何を行うかを指示する必要がある
                    NavigationLink(value : Destination.payment(loan)) {
                        LoanCellView(name: loan.wrappedName, amount: loan.totalAmount, date: loan.wrappedStartDate)
                    }
                }
                .onDelete { indexSet in
                    deleteItems(offset: indexSet)
                }
            }
            .navigationTitle("All loanes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton()
                }
            }
            .sheet(isPresented: $isAddLoanShowing) {
                AddLoanView()
            }
            
            ///NavigationLinkで渡されるdestinationによって遷移先を決める
            .navigationDestination(for: Destination.self) { destination in
                switch destination{
                case .payment(let loan):
                    PaymentsView(loan: loan)
                case .addPayment(let loan, let payment):
                    AddPaymentView(loan: loan, payment: payment)
                }
            }
        }
    }
    
    func deleteItems(offset:IndexSet){
        withAnimation {
//            offset.map{loans[$0].forEach(veiwContext.delete)
//                PersistenceController.shared.save()
//            }
        }
    }
}

struct AllLoansView_Previews: PreviewProvider {
    static var previews: some View {
        AllLoansView()
    }
}
