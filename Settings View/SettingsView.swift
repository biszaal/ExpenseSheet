//
//  AccountView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/6/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI

struct SettingsView: View
{
    @ObservedObject var store = InAppPurchaseStore()
    @State var showRemoveAds: Bool = false
    
    @State var hideAds: Bool = UserDefaults.standard.bool(forKey: "ads_removed")
    
    var body: some View
    {
        ZStack
            {
                VStack(spacing: 0)
                {
                    HStack
                        {
                            Text("Settings")
                                .font(.system(size: 30, design: .serif))
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .colorInvert()
                            
                            Spacer()
                            
                            if !hideAds
                            {
                                Button(action: {
                                    self.showRemoveAds = true
                                })
                                {
                                    VStack
                                        {
                                            Image(systemName: "nosign")
                                                .font(.system(size: 20, design: .serif))

                                            Text("Remove Ads")
                                                .font(.system(size: 10, design: .serif))
                                    }
                                    .foregroundColor(.primary)
                                    .colorInvert()
                                }
                            }
                    }
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
                                    
                                    if !hideAds
                                    {
                                        GoogleAdView(bannerId: "ca-app-pub-9776815710061950/4454932018")
                                            
                                            .frame(width: UIScreen.main.bounds.width / 1.25, height: UIScreen.main.bounds.height / 10)
                                        
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
}
