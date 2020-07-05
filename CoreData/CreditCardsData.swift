import Foundation
import CoreData


class CreditCardsData: NSManagedObject, Identifiable {
    
    @NSManaged public var creditCards: String?
}

extension CreditCardsData {
    
    static func getCreditCardsData() -> NSFetchRequest<CreditCardsData> {
        
        let request: NSFetchRequest<CreditCardsData> = CreditCardsData.fetchRequest() as! NSFetchRequest<CreditCardsData>
        
        request.sortDescriptors = []
        
        return request
    }
    
    
}
