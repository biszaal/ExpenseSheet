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
    @FetchRequest(fetchRequest: CategoriesData.getCategoriesData()) var categoriesData: FetchedResults<CategoriesData>
    @FetchRequest(fetchRequest: CreditCardsData.getCreditCardsData()) var creditCardsData: FetchedResults<CreditCardsData>
    @FetchRequest(fetchRequest: DebitCardsData.getDebitCardsData()) var debitCardsData: FetchedResults<DebitCardsData>
    
    @ObservedObject var textFieldManager = TextFieldManager(charLimit: 15)
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
                        .foregroundColor(.primary)
                }
            }
            else
            {
                TextField("Type here", text: self.$textFieldManager.text)
                Button(action: {
                    self.newItem = self.textFieldManager.text.trimmingCharacters(in: .whitespacesAndNewlines) // removes the empty white space
                    if self.newItem != "" {
                        if self.type == "category"
                        {
                            // so exist checks if the value is already exists in the cloud or core data, so if the value exist it will not save anything and return haptic feedback to the user
                            var exist = false
                            for each in self.categoriesData
                            {
                                if each.category == self.newItem
                                {
                                    exist = true
                                }
                            }
                            if !exist
                            {
                                let data = CategoriesData(context: self.managedObjectContext)
                                data.category = self.newItem
                                self.textFieldManager.text = ""
                                if data.hasChanges
                                {
                                    try? self.managedObjectContext.save()
                                }
                            } else {
                                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                impactHeavy.impactOccurred()
                            }
                        }
                        else if self.type == "credit"
                        {
                            var exist = false
                            for each in self.creditCardsData
                            {
                                if each.creditCards == self.newItem
                                {
                                    exist = true
                                }
                            }
                            if !exist
                            {
                                let data = CreditCardsData(context: self.managedObjectContext)
                                data.creditCards = self.newItem
                                self.textFieldManager.text = ""
                                if data.hasChanges
                                {
                                    try? self.managedObjectContext.save()
                                }
                            } else {
                                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                impactHeavy.impactOccurred()
                            }
                        }
                        else if self.type == "debit"
                        {
                            var exist = false
                            for each in self.debitCardsData
                            {
                                if each.debitCards == self.newItem
                                {
                                    exist = true
                                }
                            }
                            if !exist
                            {
                                let data = DebitCardsData(context: self.managedObjectContext)
                                data.debitCards = self.newItem
                                self.textFieldManager.text = ""
                                if data.hasChanges
                                {
                                    try? self.managedObjectContext.save()
                                }
                            } else
                            {
                                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                impactHeavy.impactOccurred()
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
        .background(Color.primary.colorInvert().opacity(0.5))
        .cornerRadius(20)
    }
}
