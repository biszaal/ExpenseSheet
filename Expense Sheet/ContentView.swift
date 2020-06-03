//
//  ContentView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 5/30/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            Home().tabItem
                {
                    Image(systemName: "house.fill").font(.title)
                    Text("Home")
            }
            AnalyticsView().tabItem
                {
                    Image(systemName: "chart.bar.fill").font(.title)
                    Text("Analytics")
            }
            Text("").tabItem
                {
                    Image(systemName: "gear").font(.title)
                    Text("Settings")
            }
            Text("").tabItem
                {
                    Image(systemName: "person.fill").font(.title)
                    Text("Account")
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
