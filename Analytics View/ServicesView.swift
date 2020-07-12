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
    
    @State var lengthOfBar: CGFloat = 0      // used for animation
    
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
                                .font(.system(size: UIScreen.main.bounds.width / 25))
                                .lineLimit(1)
                                
                                Spacer()
                                
                                Capsule()
                                    .frame(width: (UIScreen.main.bounds.width * (CGFloat(self.getPriceOfService(service: data.services!)) / CGFloat(self.maxPrice() + 1))) / 2.7 * self.lengthOfBar, height: UIScreen.main.bounds.height / 150)
                                    .foregroundColor(Color.init(red: Double.random(in: 100..<255) / 255, green: Double.random(in: 100..<255) / 255, blue: Double.random(in: 50..<200) / 255))
                                
                                Text(self.tooLongInt(number: self.getPriceOfService(service: data.services!)))
                                    .frame(maxWidth: UIScreen.main.bounds.width / 8)
                                    .font(.system(size: UIScreen.main.bounds.width / 30))
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
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    func maxPrice() -> Int
    {
        var maxPrice: Int = 0
        var eachServiceTotal: Int = 0
        
        for each in self.servicesData
        {
            eachServiceTotal = getPriceOfService(service: each.services!)
            
            if eachServiceTotal > maxPrice
            {
                maxPrice = eachServiceTotal
            }
        }
        return maxPrice
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
    
    func tooLongInt(number: Int) -> String// this will reduce too long integers for ex: 100,000 -> 10 k
    {
        var result: String = String(number)
        if number > 100000
        {
            result = String((number / 1000).description) + "k"
        }
        
        if number > 1000000
        {
            result = String((number / 1000).description) + "m"
        }
        return result
    }
}

