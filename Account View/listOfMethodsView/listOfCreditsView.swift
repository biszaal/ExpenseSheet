//
//  listOfServicesView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/6/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI
import CoreData

struct listOfCreditsView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: CreditCardsData.getCreditCardsData()) var creditCardsData: FetchedResults<CreditCardsData>
    
    @State var newCreditCard: String = ""
    @State var userInput: String = "Type the name of your Credit Card"
    @State var showAlert: Bool = false
    
    var body: some View
    {
        List
            {
                HStack
                    {
                        TextField(self.userInput, text: self.$newCreditCard)
                        
                        Spacer()
                        
                        Button(action: {
                            self.newCreditCard = self.newCreditCard.trimmingCharacters(in: .whitespacesAndNewlines)
                            
                            if !self.newCreditCard.isEmpty
                            {
                                var exist = false
                                for each in self.creditCardsData
                                {
                                    if each.creditCards == self.newCreditCard
                                    {
                                        exist = true
                                    }
                                }
                                if !exist
                                {
                                    let data = CreditCardsData(context: self.managedObjectContext)
                                    data.creditCards = self.newCreditCard
                                    self.newCreditCard = ""
                                    
                                    if data.hasChanges
                                    {
                                        try? self.managedObjectContext.save()
                                    }
                                }
                                else
                                {
                                    self.showAlert = true
                                }
                            }
                        })
                        {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(.green)
                        }
                }
                
                ForEach(self.creditCardsData, id: \.self)
                { data in
                    
                    Text(data.creditCards ?? "Unknown")
                }
                .onDelete{ index in
                    let deleteItem = self.creditCardsData[index.first!]
                    self.managedObjectContext.delete(deleteItem)
                    
                    try? self.managedObjectContext.save()
                    
                }
        }
        .alert(isPresented: $showAlert)
        {
            Alert(title: Text("Already Exists"), message: Text("Item cannot be added because it already exists."), dismissButton: .default(Text("OK")))
        }
        
    }
}
