//
//  LoanCell.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/25.
//

import SwiftUI

struct LoanCellView: View {
    
    let name: String
    let amount: Double
    let date: Date
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(amount, format: .currency(code: "JPY"))
//                Text(amount.toCurrency)
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            
            Spacer()
            
            Text(date.formatted(date: .abbreviated, time: .omitted))
//            Text(date.longDate)
                .font(.subheadline)
                .fontWeight(.light)
//                .foregroundColor(.secondary)
        }
    }
}

struct LoanCellView_Previews: PreviewProvider {
    static var previews: some View {
        LoanCellView(name: "Test name", amount: 1000, date: Date())
    }
}
