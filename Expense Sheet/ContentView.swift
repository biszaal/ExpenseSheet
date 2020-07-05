//
//  ContentView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 5/30/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI

struct ContentView: View
{
    
    var body: some View
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
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 15)
                
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
