//
//  Persistence.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/25.
//

import CoreData


///Appleが提供したものを編集したPersistenceController
struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    
    ///ここ追加
    var viewContext: NSManagedObjectContext{
        container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "LoanTrackerApp")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    ///保存用関数
    ///アプリ全体でのデータ管理を中央化、カプセル化して他の部分からデータベース操作を容易に行えるようにするため、PersistenceControllerにsave関数を記述する
    ///コードの再利用性とメンテナンス性が向上する
    func save() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving to CD: ", error.localizedDescription)
        }
    }
}
