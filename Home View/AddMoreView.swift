//
//  AddMoreView.swift
//  ExpenseSheet
//
//  Created by Bishal Aryal on 20/6/29.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI
import CoreData

struct AddMoreView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: ServicesData.getServicesData()) var servicesData: FetchedResults<ServicesData>
    @FetchRequest(fetchRequest: CreditCardsData.getCreditCardsData()) var creditCardsData: FetchedResults<CreditCardsData>
    @FetchRequest(fetchRequest: DebitCardsData.getDebitCardsData()) var debitCardsData: FetchedResults<DebitCardsData>
    
    
    @State var newItem: String = ""
    @State var showAddNewButton: Bool = true
    
    var type: String
    
    init(type: String)
    {
        self.type = type
    }
    
    var body: some View
    {
        HStack(spacing: UIScreen.main.bounds.width / 3)
        {
            if showAddNewButton
            {
                Button(action: {
                    self.showAddNewButton = false
                })
                {
                    Text("+ Add more")
                }
            }
            else
            {
                TextField("Type here", text: self.$newItem)
                Button(action: {
                    if !self.newItem.isEmpty {
                        if self.type == "service"
                        {
                            let data = ServicesData(context: self.managedObjectContext)
                            data.services = self.newItem
                            self.newItem = ""
                            if data.hasChanges
                            {
                                try? self.managedObjectContext.save()
                            }
                        }
                        else if self.type == "credit"
                        {
                            let data = CreditCardsData(context: self.managedObjectContext)
                            data.creditCards = self.newItem
                            self.newItem = ""
                            if data.hasChanges
                            {
                                try? self.managedObjectContext.save()
                            }
                        }
                        else if self.type == "debit"
                        {
                            let data = DebitCardsData(context: self.managedObjectContext)
                            data.debitCards = self.newItem
                            self.newItem = ""
                            if data.hasChanges
                            {
                                try? self.managedObjectContext.save()
                            }
                        }
                        
                    }
                    
                    self.showAddNewButton = true
                })
                {
                    Text("Done")
                        .foregroundColor(.blue)
                }
            }
        }
        .fixedSize(horizontal: true, vertical: false)
        .padding()
        .frame(maxWidth: UIScreen.main.bounds.width / 1.2, maxHeight: UIScreen.main.bounds.height / 20)
        .background(Color.primary.colorInvert())
        .cornerRadius(20)
    }
}
