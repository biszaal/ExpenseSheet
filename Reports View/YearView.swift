import SwiftUI
import CoreData

struct YearView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    
    var body: some View
    {
        VStack(spacing: 0)
        {
            Text("Reports")
                .font(.system(size: 30, design: .serif))
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .colorInvert()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! - 10)
                .background(Color.init(red: 38 / 255, green: 100 / 255, blue: 115 / 255))
            
            NavigationView
                {
                    List
                        {
                                ForEach(self.listOfYears(), id: \.self)
                                { each in
                                    NavigationLink(destination: MonthView(year: Int(each))
                                        .navigationBarTitle(Text(String(each)), displayMode: .inline))
                                    {
                                        Text(String(each))
                                    }
                                }
                    }
                    .navigationBarTitle("Years", displayMode: .inline)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.horizontal)
    }
    
    func listOfYears() -> [Int]
    {
        var years: [Int] = []
        for each in self.transactionData
        {
            if !years.contains(Int(each.year))
            {
                years.append(Int(each.year))
            }
        }
        return years.sorted(by: >)
    }
}
