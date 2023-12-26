//
//  ProgressBar.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/26.
//

import SwiftUI

struct ProgressBar: View {
    private let progress: Progress
    private let barHeight: CGFloat
    
    init(progress: Progress, barHeight:CGFloat = 20.0) {
        self.progress = progress
        self.barHeight = barHeight
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))
                    
                    Text(progress.leftAmount, format:.currency(code: "JPY"))
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
                
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: min(CGFloat(progress.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(Color(UIColor.systemBlue))
                    
                    Text(progress.paidAmount, format:.currency(code: "JPY"))
                        .font(.caption)
                        .padding(.horizontal)
                }
            }
            .cornerRadius(45)
        }
        .frame(height: barHeight)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: Progress())
    }
}
