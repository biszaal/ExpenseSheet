//
//  CurrencyPickerView.swift
//  ExpenseSheet
//
//  Created by Bishal Aryal on 20/7/1.
//  Copyright © 2020 Bishal Aryal. All rights reserved.

import SwiftUI

struct CurrencyPickerView: View
{
    
    @ObservedObject var textFieldManager = TextFieldManager(charLimit: 5)
    @State public var currency: String = UserDefaults.standard.string(forKey: "curr") ?? "$"
    
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
                            TextField("Example: $, €, ¥, रू, ₹", text: $textFieldManager.text)
                            Spacer()
                            Button(action: {
                                self.currency = self.textFieldManager.text.trimmingCharacters(in: .whitespacesAndNewlines) // removes the empty white space
                                if self.currency != ""
                                {
                                    UserDefaults.standard.set(self.currency, forKey: "curr")
                                    self.isTextField = false
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
    }
}
