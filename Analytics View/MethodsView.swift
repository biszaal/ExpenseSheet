//
//  ServicesView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/15/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI
import CoreData

struct MethodsView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    @FetchRequest(fetchRequest: CreditCardsData.getCreditCardsData()) var creditCardsData: FetchedResults<CreditCardsData>
    @FetchRequest(fetchRequest: DebitCardsData.getDebitCardsData()) var debitCardsData: FetchedResults<DebitCardsData>
    
    @State var lengthOfBar: CGFloat = 0
    
    var body: some View
    {
        ScrollView
            {
                VStack (alignment: .leading, spacing: UIScreen.main.bounds.height / 50)
                {
                    Section(header:
                        Text("Credit Cards")
                            .font(.system(size: 15))
                            .foregroundColor(.secondary))
                    {
                        ForEach(self.creditCardsData)
                        { data in
                            HStack
                                {
                                    Text(data.creditCards ?? "Empty")
                                    
                                    Spacer()
                                    
                                    Capsule()
                                        .frame(width: ((UIScreen.main.bounds.width * CGFloat(self.getPriceOfMethods(method: data.creditCards!))) / CGFloat(self.getTotalPrice())) / 1.2 * self.lengthOfBar, height: UIScreen.main.bounds.height / 150)
                                        .foregroundColor(Color.init(red: Double.random(in: 100..<255) / 255, green: Double.random(in: 100..<255) / 255, blue: Double.random(in: 50..<200) / 255))
                                    
                                    Text(String(self.getPriceOfMethods(method: data.creditCards!)))
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
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Section(header:
                        Text("Debit Cards and Cash")
                            .font(.system(size: 15))
                            .foregroundColor(.secondary))
                    {
                        ForEach(self.debitCardsData)
                        { data in
                            HStack
                                {
                                    Text(data.debitCards ?? "Empty")
                                    
                                    Spacer()
                                    
                                    Capsule()
                                        .frame(width: ((UIScreen.main.bounds.width * CGFloat(self.getPriceOfMethods(method: data.debitCards!))) / CGFloat(self.getTotalPrice())) / 1.2 * self.lengthOfBar, height: UIScreen.main.bounds.height / 150)
                                        .foregroundColor(Color.init(red: Double.random(in: 100..<255) / 255, green: Double.random(in: 100..<255) / 255, blue: Double.random(in: 50..<200) / 255))
                                    
                                    Text(String(self.getPriceOfMethods(method: data.debitCards!)))
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
    
    func getPriceOfMethods(method: String) -> Int
    {
        var price: Int = 0
        
        for each in self.transactionData {
            if each.method == method {
                price += Int(each.price)
            }
        }
        
        return price
    }
}

