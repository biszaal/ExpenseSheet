import Foundation
import CoreData


class ServicesData: NSManagedObject, Identifiable {
    
    @NSManaged public var services: String?
}

extension ServicesData {
    
    static func getServicesData() -> NSFetchRequest<ServicesData> {
        
        let request: NSFetchRequest<ServicesData> = ServicesData.fetchRequest() as! NSFetchRequest<ServicesData>
        
        request.sortDescriptors = []
        
        return request
    }
    
    
}
