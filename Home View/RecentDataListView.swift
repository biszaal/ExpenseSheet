//
//  RecentData.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/1/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI
import CloudKit
import CoreData

struct RecentDataListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    
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
                                        Text("\(self.transactionData[each].year)" + "/" + "\(self.transactionData[each].month)" + "/" + "\(self.transactionData[each].day)")
                                            .font(.system(size: 10))
                                        Text("\(self.transactionData[each].transaction ?? "Unknown"), \(self.transactionData[each].price.description)$, \(self.transactionData[each].type ?? "Unknown")")
                                            .font(.system(size: 15))
                                }
                                .lineLimit(1)
                                
                            }
                            .onDelete{ index in
                                let deleteItem = self.transactionData[index.first!]
                                self.managedObjectContext.delete(deleteItem)
                                
                                try? self.managedObjectContext.save()
                                
                            }
                        }
                }
                .cornerRadius(10)
                .padding()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.5)
                .shadow(radius: 5)
                
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
