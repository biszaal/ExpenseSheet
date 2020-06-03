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
    @FetchRequest(fetchRequest: Data.getData()) var data: FetchedResults<Data>
    
    var body: some View
    {
            List
                {
                    Section (header: Text("Recent Transaction"))
                    {
                    ForEach(self.data, id: \.self)
                    { each in
                        
                        Text("\(String(each.year))/\(each.month)/\(each.day) \t \(each.transaction!) \t \(each.price.description) \t \(each.type!) \t \(each.will!)")
                        
                    }
                    .onDelete{ index in
                        let deleteItem = self.data[index.first!]
                        self.managedObjectContext.delete(deleteItem)
                        
                        try? self.managedObjectContext.save()
                        
                    }
                    }
        }
        .cornerRadius(10)
        .padding()
        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 3)
        .shadow(radius: 5)
    }
}

struct RecentDataListView_Previews: PreviewProvider {
    static var previews: some View {
        RecentDataListView()
    }
}
