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
    @State var selectedCurrency: String = "-"
    
    @ObservedObject var currencyLogo = StoreData()
    
    var body: some View {
        
        List(currencyLogo.currencyData, id: \.id)
        { curr in
            Text("curr.code")
        }
    }
}

struct CurrencyPickerView_Preview: PreviewProvider{
    static var previews: some View {
        CurrencyPickerView()
    }
}
