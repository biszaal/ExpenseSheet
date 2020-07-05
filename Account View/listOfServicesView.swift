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
    
    var body: some View
    {
        VStack{
        List
            {
                Section(header: Text("Services"))
                {
                    HStack
                        {
                            
                            TextField(self.userInput, text: self.$newService)
                            
                            Spacer()
                            
                            Button(action: {
                                if !self.newService.isEmpty {
                                    let data = ServicesData(context: self.managedObjectContext)
                                    data.services = self.newService
                                    self.newService = ""
                                    
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
        Spacer()
            .frame(height: UIScreen.main.bounds.height / 50)
        }
    }


}

