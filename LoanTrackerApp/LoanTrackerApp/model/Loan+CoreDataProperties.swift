//
//  Loan+CoreDataProperties.swift
//  LoanTrackerApp
//
//  Created by koala panda on 2023/12/25.
//
//

import Foundation
import CoreData


extension Loan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Loan> {
        return NSFetchRequest<Loan>(entityName: "Loan")
    }

    @NSManaged public var dueDate: Date?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var totalAmount: Double
    @NSManaged public var payments: NSSet?

    public var wrappedStartDate: Date{
        startDate ?? Date()
    }
    
    public var wrappedDueDate: Date{
        dueDate ?? Date()
    }
    
    
    public var wrappedName: String{
        name ?? "Unknown"
    }
    
    public var paymentArray: [Payment]{
        let set = payments as? Set<Payment> ?? []
        return set.sorted{
            //日付順でソート
            $0.wrappedDate < $1.wrappedDate
        }
    }
}

// MARK: Generated accessors for payments
extension Loan {

    @objc(addPaymentsObject:)
    @NSManaged public func addToPayments(_ value: Payment)

    @objc(removePaymentsObject:)
    @NSManaged public func removeFromPayments(_ value: Payment)

    @objc(addPayments:)
    @NSManaged public func addToPayments(_ values: NSSet)

    @objc(removePayments:)
    @NSManaged public func removeFromPayments(_ values: NSSet)

}

extension Loan : Identifiable {

}
