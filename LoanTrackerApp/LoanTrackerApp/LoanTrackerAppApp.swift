//
//  LoanTrackerAppApp.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/25.
//

import SwiftUI

@main
struct LoanTrackerAppApp: App {
    var body: some Scene {
        WindowGroup {
            AllLoansView()
            ///Core DataのNSManagedObjectContextをContentViewや子ビューに提供
            ///データの保存や取得などのデータベース操作をアプリ全体で行えるようにするための重要な設定
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
