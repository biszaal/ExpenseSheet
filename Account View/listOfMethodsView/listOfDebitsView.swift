//
//  listOfServicesView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/6/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI
import CoreData

struct listOfDebitsView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: DebitCardsData.getDebitCardsData()) var debitCardsData: FetchedResults<DebitCardsData>
    
    @State var newDebitCard: String = ""
    @State var userInput: String = "Type the name of your Debit Card"
    
    var body: some View
    {
        List
            {
                HStack
                    {
                        TextField(self.userInput, text: self.$newDebitCard)
                        
                        Spacer()
                        
                        Button(action: {
                            if !self.newDebitCard.isEmpty {
                                let data = DebitCardsData(context: self.managedObjectContext)
                                data.debitCards = self.newDebitCard
                                self.newDebitCard = ""
                                
                                if data.hasChanges
                                {
                                    try? self.managedObjectContext.save()
                                }
                            }
                        })
                        {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(.green)
                        }
                }
                
                ForEach(self.debitCardsData, id: \.self)
                { data in
                    
                    Text(data.debitCards ?? "Unknown")
                }
                .onDelete{ index in
                    let deleteItem = self.debitCardsData[index.first!]
                    self.managedObjectContext.delete(deleteItem)
                    
                    try? self.managedObjectContext.save()
                    
                }
        }
    }
}
