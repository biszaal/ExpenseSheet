//
//  SplashScreenView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/7/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI

struct SplashScreenView: View
{
    @State var screenView: Int = 1
    @State var viewBackButton: Bool = false
    @State var viewNextButton: Bool = true
    var body: some View
    {
        ZStack
            {
                VStack(spacing: 5)
                {
                    
                    Text("Welcome to Expense Sheet App")
                        .font(.system(size: UIScreen.main.bounds.width / 20, design: .serif))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! + 5)
                        .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                        .background(Color.init(red: 38 / 255, green: 100 / 255, blue: 115 / 255))
                    
                    if screenView == 1
                    {
                        Section(header:
                            Text("Enter Services")
                                .font(.body)
                                .foregroundColor(.secondary))
                        {
                            listOfServicesView()
                                .cornerRadius(10)
                                .padding(.horizontal)
                                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 2)
                                .shadow(radius: 5)
                        }
                        .onAppear()
                        {
                            self.viewBackButton = false
                            self.viewNextButton = true
                        }
                    }
                    
                    if screenView == 2
                    {
                        Section(header:
                            Text("Enter Your Credit and Debit Card Names")
                                .font(.body)
                                .foregroundColor(.secondary))
                        {
                            listOfMethodsView()
                                .cornerRadius(10)
                                .padding(.horizontal)
                                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 2)
                                .shadow(radius: 5)
                        }
                    .onAppear()
                        {
                            self.viewBackButton = true
                            self.viewNextButton = true
                        }
                    }
                    if screenView == 3
                    {
                        Section(header:
                            Text("Enter Your Currency Symbol")
                                .font(.body)
                                .foregroundColor(.secondary))
                        {
                            CurrencyPickerView()
                                .padding()
                                .background(Color.secondary.opacity(0.5))
                                .cornerRadius(10)
                                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 8)
                                .shadow(radius: 5)
                        }
                        .padding()
                    .onAppear()
                        {
                            self.viewNextButton = false
                            self.viewBackButton = true
                        }
                    }
                    
                    Spacer()
                    
                    HStack
                        {
                            if self.viewBackButton
                            {
                                Button(action: {
                                    if self.screenView > 1
                                    {
                                        self.screenView -= 1
                                    }
                                })
                                {
                                    Image(systemName: "arrow.left")
                                        .font(.title)
                                        .padding()
                                }
                            }
                            Spacer()
                            
                            if self.viewNextButton
                            {
                                Button(action: {
                                    if self.screenView < 3
                                    {
                                        self.screenView += 1
                                    }
                                    if self.screenView == 1
                                    {
                                        self.viewBackButton = true
                                    }
                                })
                                {
                                    Image(systemName: "arrow.right")
                                        .font(.title)
                                        .padding()
                                }
                            }
                    }
                }
                .edgesIgnoringSafeArea(.top)
        }
        
    }
}
