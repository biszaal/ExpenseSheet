import Foundation
import CoreData


class DebitCardsData: NSManagedObject, Identifiable {
    
    @NSManaged public var debitCards: String?
}

extension DebitCardsData {
    
    static func getDebitCardsData() -> NSFetchRequest<DebitCardsData> {
        
        let request: NSFetchRequest<DebitCardsData> = DebitCardsData.fetchRequest() as! NSFetchRequest<DebitCardsData>
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \DebitCardsData.debitCards, ascending: true)]
        
        return request
    }
    
    
}
