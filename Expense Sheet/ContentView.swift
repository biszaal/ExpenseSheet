//
//  ContentView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 5/30/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI
import CoreData
import CloudKit

struct ContentView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: CreditCardsData.getCreditCardsData()) var creditCardsData: FetchedResults<CreditCardsData>
    @FetchRequest(fetchRequest: DebitCardsData.getDebitCardsData()) var debitCardsData: FetchedResults<DebitCardsData>
    @FetchRequest(fetchRequest: ServicesData.getServicesData()) var servicesData: FetchedResults<ServicesData>
    
    @State var hideSplashScreen = NSUbiquitousKeyValueStore().bool(forKey: "splash")
    
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
                                        Image(systemName: "house.fill").font(.title)
                                        Text("Home")
                                }
                                
                                AnalyticsView().tabItem
                                    {
                                        Image(systemName: "chart.pie.fill").font(.title)
                                        Text("Analytics")
                                }
                                
                                YearView().tabItem
                                    {
                                        Image(systemName: "folder.fill").font(.title)
                                        Text("Reports")
                                }
                                
                                AccountView().tabItem
                                    {
                                        Image(systemName: "person.fill").font(.title)
                                        Text("Account")
                                }
                        }
                        Spacer()
                        GoogleAdView(bannerId: "ca-app-pub-9776815710061950/1924102059")
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 14)
                        
                }
                .edgesIgnoringSafeArea(.bottom)
                
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
                                self.hideSplashScreen = true
                                NSUbiquitousKeyValueStore().set(self.hideSplashScreen, forKey: "splash")
                            }) {
                                Text("Continue")
                                    .padding()
                            }
                    }
                    .background(Color.white)
                }
        }
    }
    
    // storing default value on the first time of access to the app
    func storeDefaultValue ()
    {
        
        let defaultServices = ["Food", "Education", "Transportation", "Bills", "Entertainment"]
        let defaultCreditCards = ["Visa", "Master Card"]
        let defaultDebitCards = ["Cash"]
        
        for creditCard in defaultCreditCards
        {
            let value = CreditCardsData(context: self.managedObjectContext)
            value.creditCards = creditCard
            try? self.managedObjectContext.save()
        }
        
        for debitCard in defaultDebitCards
        {
            let value = DebitCardsData(context: self.managedObjectContext)
            value.debitCards = debitCard
            try? self.managedObjectContext.save()
        }
        
        for service in defaultServices
        {
            let value = ServicesData(context: self.managedObjectContext)
            value.services = service
            try? self.managedObjectContext.save()
        }
        
    }
}

