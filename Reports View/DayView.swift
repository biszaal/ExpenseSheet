import SwiftUI
import CoreData

struct DayView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    
    var month: Int
    var year: Int
    
    init (year: Int, month: Int) {
        self.year = year
        self.month = month
    }
    
    var body: some View
    {
        List{
            ForEach(self.transactionData)
            { each in
                if each.year == self.year && each.month == self.month
                {
                    Text("Day \(each.day) \(each.transaction ?? "") \(each.price.description)$ \(each.type ?? "") \(each.will ?? "")")
                    .lineLimit(1)

                }
            }
            .onDelete{ index in
                let deleteItem = self.transactionData[index.first!]
                self.managedObjectContext.delete(deleteItem)
                
                try? self.managedObjectContext.save()
                
            }
        }
    }
}
