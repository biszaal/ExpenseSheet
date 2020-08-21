//
//  listOfCategoriesView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/6/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI
import CoreData

struct listOfCategoriesView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: CategoriesData.getCategoriesData()) var categoriesData: FetchedResults<CategoriesData>
    
    @ObservedObject var textFieldManager = TextFieldManager(charLimit: 15)
    @State var newCategory: String = ""
    @State var userInput: String = "Example: Food, Transportation, Rent"
    @State var showAlert: Bool = false
    
    var body: some View
    {
        List
            {
                Section(header: Text("Categories"))
                {
                    HStack
                        {
                            TextField(self.userInput, text: self.$textFieldManager.text)
                            
                            Spacer()
                            
                            Button(action: {
                                self.newCategory = self.textFieldManager.text.trimmingCharacters(in: .whitespacesAndNewlines) // removes the empty white space
                                
                                if !self.newCategory.isEmpty {
                                    var exist = false
                                    for each in self.categoriesData
                                    {
                                        if each.category == self.newCategory
                                        {
                                            exist = true
                                        }
                                    }
                                    if !exist
                                    {
                                        let data = CategoriesData(context: self.managedObjectContext)
                                        data.category = self.newCategory
                                        self.textFieldManager.text = ""
                                        if data.hasChanges
                                        {
                                            try? self.managedObjectContext.save()
                                        }
                                    } else
                                    {
                                        self.textFieldManager.text = ""
                                        self.showAlert = true
                                        let notificationGenerator = UINotificationFeedbackGenerator()
                                        notificationGenerator.notificationOccurred(.warning)
                                    }
                                }
                            })
                            {
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                                    .foregroundColor(.green)
                            }
                    }
                    
                    ForEach(self.categoriesData, id: \.self)
                    { data in
                        
                        Text(data.category ?? "-")
                    }
                    .onDelete
                        { index in
                            let deleteItem = self.categoriesData[index.first!]
                            self.managedObjectContext.delete(deleteItem)
                            
                            try? self.managedObjectContext.save()
                            
                    }
                }
                
        }
        .alert(isPresented: $showAlert)
        {
            Alert(title: Text("Already Exists"), message: Text("Item cannot be added because it already exists."), dismissButton: .default(Text("OK")))
        }
    }
    
    
}

