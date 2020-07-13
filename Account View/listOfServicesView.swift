//
//  listOfServicesView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/6/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI
import CoreData

struct listOfServicesView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: ServicesData.getServicesData()) var servicesData: FetchedResults<ServicesData>
    
    @State var newService: String = ""
    @State var userInput: String = "Example: Food, Transportation, Rent"
    @State var showAlert: Bool = false
    
    var body: some View
    {
        List
            {
                Section(header: Text("Services"))
                {
                    HStack
                        {
                            
                            TextField(self.userInput, text: self.$newService)
                            
                            Spacer()
                            
                            Button(action: {
                                self.newService = self.newService.trimmingCharacters(in: .whitespacesAndNewlines)
                                
                                if !self.newService.isEmpty {
                                    var exist = false
                                    for each in self.servicesData
                                    {
                                        if each.services == self.newService
                                        {
                                            exist = true
                                        }
                                    }
                                    if !exist
                                    {
                                        let data = ServicesData(context: self.managedObjectContext)
                                        data.services = self.newService
                                        self.newService = ""
                                        
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
                    
                    ForEach(self.servicesData, id: \.self)
                    { data in
                        
                        Text(data.services ?? "-")
                    }
                    .onDelete
                        { index in
                            let deleteItem = self.servicesData[index.first!]
                            self.managedObjectContext.delete(deleteItem)
                            
                            try? self.managedObjectContext.save()
                            
                    }
                }
        }
        .padding(.bottom, UIScreen.main.bounds.height / 10)
        .alert(isPresented: $showAlert)
    {
        Alert(title: Text("Already Exists"), message: Text("Item cannot be added because it already exists."), dismissButton: .default(Text("OK")))
        }
    }
    
    
}

