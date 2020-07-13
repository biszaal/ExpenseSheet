//
//  AnalyticsView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/3/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI

struct AnalyticsView: View
{
    @State var currentTab = "services"
    
    var body: some View
    {
        
        VStack
            {
                Text("Analytics")
                    .font(.system(size: 30, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .colorInvert()
                    .padding()
                    .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! - 10)
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                    .background(Color.init(red: 38 / 255, green: 100 / 255, blue: 115 / 255))
                
                VStack
                    {
                        HStack
                            {
                                WillChart()
                                
                                TypeChart()
                                
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.09)
                        
                        Spacer()
                            .frame(height: UIScreen.main.bounds.height / 20)
                        
                        Picker(selection: $currentTab, label: Text(""))
                        {
                            Text("Services").tag("services")
                            Text("Payment Methods").tag("methods")
                        }
                        .padding()
                        .pickerStyle(SegmentedPickerStyle())
                        
                        if currentTab == "services"
                        {
                            ServicesView()
                            .padding()
                        }
                        else if currentTab == "methods"
                        {
                            MethodsView()
                            .padding()
                        }
                }
        }
        .edgesIgnoringSafeArea(.top)
    }
}
