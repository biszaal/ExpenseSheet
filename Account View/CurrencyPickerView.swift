//
//  CurrencyPickerView.swift
//  ExpenseSheet
//
//  Created by Bishal Aryal on 20/7/1.
//  Copyright © 2020 Bishal Aryal. All rights reserved.

import SwiftUI
import CloudKit

struct CurrencyPickerView: View
{
    @State public var currency: String = NSUbiquitousKeyValueStore().string(forKey: "curr") ?? "$"
    
    @State var isTextField: Bool = false
    @State var currencySavedAlert: Bool = false
    @State var overlayLoading: String = ""
    
    var body: some View {
        
        ZStack
            {
                if isTextField
                {
                    HStack
                        {
                            TextField("Example: $, €, ¥, रू, ₹", text: $currency)
                            Spacer()
                            Button(action: {
                                NSUbiquitousKeyValueStore().set(self.currency, forKey: "curr")
                                NSUbiquitousKeyValueStore().synchronize()
                                self.overlayLoading = "Saving to the iCloud..."
                                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                    self.isTextField = false
                                    self.overlayLoading = ""
                                    self.currencySavedAlert = true
                                }
                                
                            })
                            {
                                Text("Done")
                                    .foregroundColor(Color.blue) 
                            }
                    }
                    
                }
                else {
                    HStack
                        {
                            Text("Currency Selected : \(currency)")
                            Spacer()
                            Button(action: {
                                self.isTextField = true
                            })
                            {
                                Text("Edit")
                                    .foregroundColor(Color.blue)
                            }
                    }
                }
        }
        .overlay(Text(self.overlayLoading))
        .alert(isPresented: $currencySavedAlert) { () -> Alert in
            Alert(title: Text("Saved"), message: Text("The app needs to restart to see the change."), primaryButton: .default(Text("Restart Now"), action: {
                exit(0)
            }), secondaryButton: .default(Text("Restart Later")))
        }
    }
}
