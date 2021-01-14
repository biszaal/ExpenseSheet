//
//  ContentView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 5/30/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View
{
    @EnvironmentObject private var store: InAppPurchaseStore
    
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: CreditCardsData.getCreditCardsData()) var creditCardsData: FetchedResults<CreditCardsData>
    @FetchRequest(fetchRequest: DebitCardsData.getDebitCardsData()) var debitCardsData: FetchedResults<DebitCardsData>
    @FetchRequest(fetchRequest: CategoriesData.getCategoriesData()) var categoriesData: FetchedResults<CategoriesData>
    
    @State var hideSplashScreen = UserDefaults.standard.bool(forKey: "splash") // default value is false 
    
    var body: some View
    {
        ZStack
            {
                VStack
                    {
                        TabView
                            {
                                Home().tabItem
                                    {
                                        Image(systemName: "house.fill")
                                        Text("Home")
                                }
                                
                                AnalyticsView().tabItem
                                    {
                                        Image(systemName: "chart.pie.fill")
                                        Text("Analytics")
                                }
                                
                                YearView().tabItem
                                    {
                                        Image(systemName: "folder.fill")
                                        Text("Reports")
                                }
                                
                                SettingsView().tabItem
                                    {
                                        Image(systemName: "gear")
                                        Text("Settings")
                                }
                        }
                        
                }
                
                // only runs when the app lunchs for the first time
                if !self.hideSplashScreen
                {
                    VStack
                        {
                            
                            SplashScreenView()
                                .onAppear() {
                                    self.storeDefaultValue()
                            }
                            
                            Button(action: {
                                self.hideSplashScreen.toggle()
                                UserDefaults.standard.set(self.hideSplashScreen, forKey: "splash")
                            }) {
                                Text("Finish")
                                    .padding()
                            }
                    }
                    .background(Color.primary.colorInvert())
                }
        }
    }
    
    // storing default value on the first time of access to the app
    func storeDefaultValue ()
    {
        
        let defaultCategories = ["Food", "Education", "Transportation", "Bills", "Entertainment"]
        let defaultCreditCards = ["Visa", "Master Card"]
        let defaultDebitCards = ["Cash"]
        
        for creditCard in defaultCreditCards
        {
            var exist = false
            for each in self.creditCardsData
            {
                if each.creditCards == creditCard
                {
                    exist = true
                    break
                }
            }
            if !exist
            {
                let value = CreditCardsData(context: self.managedObjectContext)
                value.creditCards = creditCard
                try? self.managedObjectContext.save()
            }
        }
        
        for debitCard in defaultDebitCards
        {
            var exist = false
            for each in self.debitCardsData
            {
                if each.debitCards == debitCard
                {
                    exist = true
                    break
                }
            }
            if !exist
            {
                let value = DebitCardsData(context: self.managedObjectContext)
                value.debitCards = debitCard
                try? self.managedObjectContext.save()
            }
        }
        
        for category in defaultCategories
        {
            var exist = false
            for each in self.categoriesData
            {
                if each.category == category
                {
                    exist = true
                    break
                }
            }
            if !exist
            {
                let value = CategoriesData(context: self.managedObjectContext)
                value.category = category
                try? self.managedObjectContext.save()
            }
        }
        
    }
}

