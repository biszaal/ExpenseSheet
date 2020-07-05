//
//  ServicesView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/15/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI
import CoreData

struct ServicesView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    @FetchRequest(fetchRequest: ServicesData.getServicesData()) var servicesData: FetchedResults<ServicesData>
    
    @State var lengthOfBar: CGFloat = 0
    
    var body: some View
    {
        ScrollView
            {
                VStack (alignment: .leading, spacing: UIScreen.main.bounds.height / 50)
                {
                    ForEach(self.servicesData)
                    { data in
                        HStack
                            {
                                Text(data.services ?? "Empty")
                                
                                Spacer()
                                
                                Capsule()
                                    .frame(width: ((UIScreen.main.bounds.width * CGFloat(self.getPriceOfService(service: data.services!))) / CGFloat(self.getTotalPrice())) / 1.2 * self.lengthOfBar, height: UIScreen.main.bounds.height / 150)
                                    .foregroundColor(Color.init(red: Double.random(in: 100..<255) / 255, green: Double.random(in: 100..<255) / 255, blue: Double.random(in: 50..<200) / 255))
                                
                                Text(String(self.getPriceOfService(service: data.services!)))
                                    .font(.system(size: 15))
                                    .frame(maxWidth: 50)
                        }
                    }
                    .onAppear
                            {
                                withAnimation(.linear(duration: 1))
                                    {
                                self.lengthOfBar = 1
                                }
                        }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .padding()
    }
    
    func getTotalPrice() -> Int
    {
        var total: Int = 0
        
        for each in self.transactionData {
            total += Int(each.price)
        }
        
        return total
    }
    
    func getPriceOfService(service: String) -> Int
    {
        var price: Int = 0
        
        for each in self.transactionData {
            if each.service == service {
                price += Int(each.price)
            }
        }
        
        return price
    }
}

