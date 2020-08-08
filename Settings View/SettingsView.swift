//
//  AccountView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/6/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(spacing: 0)
        {
            Text("Settings")
                .font(.system(size: 30, design: .serif))
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .colorInvert()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! - 10)
                .background(Color.init(red: 38 / 255, green: 100 / 255, blue: 115 / 255))
            
            NavigationView
                {
                    Form
                        {
                            Section(header: Text("Info"))
                            {
                                NavigationLink(
                                    destination: listOfCategoriesView()
                                        .navigationBarTitle(Text("List of Categories"), displayMode: .inline))
                                {
                                    Text("List of Categories")
                                }
                                
                                NavigationLink(
                                    destination: listOfMethodsView()
                                        .navigationBarTitle(Text("List of Payment Methods"), displayMode: .inline))
                                {
                                    Text("List of Payment Methods")
                                }
                            }
                            
                            Section(header: Text("Change Currency Symbol"))
                            {
                                CurrencyPickerView()
                            }
                            
                            Section(header: Text("Support Creator"))
                            {
                                SupportCreator()
                                .foregroundColor(.primary)
                            }
                            
                            
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .padding(1)
        }
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.horizontal)
    }
}
