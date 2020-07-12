//
//  AccountView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/6/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        VStack(spacing: 0)
        {
            Text("Account")
                .font(.system(size: 30, design: .serif))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
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
                                    destination: listOfServicesView()
                                        .navigationBarTitle(Text("List of Services"), displayMode: .inline))
                                {
                                    Text("List of Services")
                                }
                                
                                NavigationLink(
                                    destination: listOfMethodsView()
                                        .navigationBarTitle(Text("List of Payment Methods"), displayMode: .inline))
                                {
                                    Text("List of Payment Methods")
                                }
                            }
                            
                            Section(header: Text("Details"))
                            {
                                CurrencyPickerView()
                            }
                    }
                    .padding(.bottom, UIScreen.main.bounds.height / 10)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
