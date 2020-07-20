import Foundation
import CoreData


class CategoriesData: NSManagedObject, Identifiable {
    
    @NSManaged public var category: String?
}

extension CategoriesData {
    
    static func getCategoriesData() -> NSFetchRequest<CategoriesData> {
        
        let request: NSFetchRequest<CategoriesData> = CategoriesData.fetchRequest() as! NSFetchRequest<CategoriesData>
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CategoriesData.category, ascending: true)]
        
        return request
    }
    
    
}
