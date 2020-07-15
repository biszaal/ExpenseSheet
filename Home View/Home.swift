//
//  Home.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 5/30/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI
import CoreData

struct Home: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    
    @State var showTransactionView = false
    
    @State var yearStat = Calendar.current.component(.year, from: Date())
    @State var monthlyStatView = true
    
    var body: some View
    {
        
        ZStack
            {
                VStack
                    {
                        HStack
                            {
                        Text("Expense Sheet")
                            .font(.system(size: 30, design: .serif))
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .colorInvert()
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    withAnimation {
                                        self.showTransactionView.toggle()
                                    }
                                }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: UIScreen.main.bounds.width / 13.5))
                                        .foregroundColor(.white)
                                        .background(
                                            Circle()
                                                .fill(Color.blue)
                                                .padding()
                                                .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 10)
                                    )
                                        .padding(.horizontal)
                                }
                        }
                            .padding()
                            .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! - 10)
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .background(Color.init(red: 38 / 255, green: 100 / 255, blue: 115 / 255))
                        
                        RecentDataListView()
                        .cornerRadius(10)
                        .padding()
                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 3)
                            .shadow(radius: 5)
                        
                        VStack
                            {
                                Button(action: {
                                    withAnimation
                                        {
                                            self.monthlyStatView.toggle()
                                    }
                                })
                                {
                                    HStack
                                        {
                                            Text(String(yearStat))
                                                .foregroundColor(.primary)
                                            Image(systemName: "chevron.down.square.fill")
                                                .cornerRadius(.infinity)
                                    }
                                }
                                .font(.system(size: UIScreen.main.bounds.width / 20, design: .serif))
                                .padding()
                                
                                if monthlyStatView
                                {
                                    MonthlyExpenses(year: yearStat)
                                } else
                                {
                                    
                                    Picker(selection: $yearStat, label: Text("")) {
                                        ForEach(self.listOfYears(), id: \.self) { eachYear in
                                            Text(String(eachYear))
                                        }
                                    }
                                    .labelsHidden()
                                    .frame(maxHeight: UIScreen.main.bounds.height / 5)
                                    .padding()
                                    
                                    Button(action: {
                                        withAnimation
                                            {
                                                self.monthlyStatView = true
                                        }
                                    }) {
                                        Text("Done")
                                            .font(.system(size: 20, design: .serif))
                                            .foregroundColor(.white)
                                            .padding()
                                            .frame(width: UIScreen.main.bounds.width / 4 , height: UIScreen.main.bounds.height / 20)
                                            .background(Color.init(red: 254 / 255, green: 95 / 255, blue: 85 / 255).opacity(0.8))
                                            .cornerRadius(20)
                                            .shadow(radius: 20)
                                    }
                                    Spacer()
                                        .frame(height: UIScreen.main.bounds.height / 40)
                                }
                                
                                GoogleAdView(bannerId: "ca-app-pub-9776815710061950/1924102059")
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 18)
                        }
                        
                }
                
                
                if self.showTransactionView
                {
                    GeometryReader
                        {
                            _ in
                            
                            NewTransactionView()
                    }
                    .background(
                        Color.black.opacity(0.6)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                withAnimation {
                                    self.showTransactionView.toggle()
                                }
                    })
                }
                
        }
            .edgesIgnoringSafeArea(.top)
    }
    
    func listOfYears() -> [Int]
    {
        var years: [Int] = []
        for each in self.transactionData
        {
            if !years.contains(Int(each.year))
            {
                years.append(Int(each.year))
            }
        }
        return years.sorted(by: >)
    }
    
}
