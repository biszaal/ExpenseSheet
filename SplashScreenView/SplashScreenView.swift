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
    var body: some View
    {
        ZStack
            {
                VStack(spacing: 10)
                {
                    
                    Text("Welcome to Expense Sheet App")
                        .font(.system(size: UIScreen.main.bounds.width / 18, design: .serif))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! + 10)
                        .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                        .background(Color.init(red: 38 / 255, green: 100 / 255, blue: 115 / 255))
                    
                    Section(header:
                        Text("Enter Services")
                            .font(.body)
                            .foregroundColor(.secondary))
                    {
                        listOfServicesView()
                            .cornerRadius(10)
                            .padding()
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 3)
                            .shadow(radius: 5)
                    }
                    Section(header:
                        Text("Enter Your Credit and Debit Card Names")
                            .font(.body)
                            .foregroundColor(.secondary))
                    {
                        listOfMethodsView()
                            .cornerRadius(10)
                            .padding()
                            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 3)
                            .shadow(radius: 5)
                    }
                    
                }
                .background(LinearGradient(gradient: .init(colors: [.blue,.white]), startPoint: .top, endPoint: .bottom))
                .edgesIgnoringSafeArea(.all)
        }
        
    }
}
