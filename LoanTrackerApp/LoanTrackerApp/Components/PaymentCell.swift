//
//  PaymentCell.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/26.
//

import SwiftUI

struct PaymentCell: View {
    let amount: Double
    let date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(amount, format: .currency(code: "JPY"))
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(date.formatted(date: .abbreviated, time: .omitted))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct PaymentCell_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCell(amount: 100, date: Date.now)
    }
}
