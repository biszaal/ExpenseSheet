//
//  CurrencyPickerView.swift
//  ExpenseSheet
//
//  Created by Bishal Aryal on 20/7/1.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI

struct CurrencyPickerView: View
{
    @State public var currencyLogo = "$"
    
    @State var isTextField = false
    
    var body: some View {
        VStack
            {
                if isTextField
                {
                    HStack
                        {
                            TextField("Example: $, €, ¥, रू, ₹", text: $currencyLogo)
                            Spacer()
                            Button(action: {
                                self.isTextField = false
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
                            Text("Currency Selected : \(currencyLogo)")
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
