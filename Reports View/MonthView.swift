import SwiftUI
import CoreData

struct MonthView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    
    var year: Int
    
    init (year: Int) {
        self.year = year
    }
    
    var body: some View
    {
        List
            {
                ForEach(self.listOfMonths(), id: \.self)
                { each in
                    NavigationLink(destination: DayView(year: Int(self.year), month: Int(each))
                        .navigationBarTitle("\(String(self.year)) \(self.monthToString(month: each))", displayMode: .inline))
                    {
                        Text(self.monthToString(month: each))
                    }
                }
                
        }
    }
    
    func monthToString(month: Int) -> String  //convert Integer months to string
    {
        let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        
        return months[month - 1]
    }
    
    func listOfMonths() -> [Int]
    {
        var months: [Int] = []
        for each in self.transactionData
        {
            if each.year == self.year {
                if !months.contains(Int(each.month))
                {
                    months.append(Int(each.month))
                }
            }
        }
        return months.sorted()
    }
}
