import SwiftUI
import CloudKit
import CoreData

struct RecentDataListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>

    @State var currencyLogo = CurrencyPickerView().currency

    var body: some View
    {
                List
                    {
                        Section (header: Text("Recent Transaction"))
                        {
                            ForEach(0 ..< numberOfRecentList())
                            { each in

                                HStack
                                    {
                                    
                                    Text(String(self.transactionData[each].transaction ?? "Unknown"))
                                    Text(String(self.transactionData[each].category ?? "Unknown"))
                                    Text(String(self.transactionData[each].price.description))
                                    Text(String(self.currencyLogo))
                                    Text(String(self.transactionData[each].type ?? "Unknown"))
                                    Text(String(self.transactionData[each].will ?? "Unknown"))
                                }
                                .font(.system(size: 15))
                                .lineLimit(1)

                            }
                            .onDelete{ index in
                                let deleteItem = self.transactionData[index.first!]
                                self.managedObjectContext.delete(deleteItem)

                                try? self.managedObjectContext.save()
                            }
                        }
                }

    }

    // This function will tell how many list to view in Recent Transaction tab to prevent app crashing when total data is less then 10
    func numberOfRecentList() -> Int
    {
        var num = 10
        if self.transactionData.count < 10
        {
            num = self.transactionData.count
        }
        return num
    }


}
