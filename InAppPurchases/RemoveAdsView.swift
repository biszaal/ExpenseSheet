//
//  RemoveAdsView.swift
//  ExpenseSheet
//
//  Created by Bishal Aryal on 20/8/18.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI

struct RemoveAdsView: View
{
    @ObservedObject var iap = InAppPurchases()
    
    @State var showAlert: Bool = false
    
    var body: some View
    {
        VStack
            {
                Text("Enjoy Expense Sheet Ads Free")
                    .font(.title)
                
                Spacer()
                    .frame(height: UIScreen.main.bounds.height / 3)
                
                HStack
                    {
                        Button(action:{
                            self.iap.purchasePressed(self)
                        })
                        {
                            Text("Buy")
                                .padding()
                                .fixedSize()
                                .frame(width: UIScreen.main.bounds.width / 4)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                            .frame(width: UIScreen.main.bounds.width / 3)
                        
                        Button(action:{
                            self.iap.restorePressed(self)
                        })
                        {
                            Text("Restore")
                                .padding()
                                .fixedSize()
                                .frame(width: UIScreen.main.bounds.width / 4)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                }
                
                Text(String(self.iap.purchaseLabel))
        }
    }
}

struct RemoveAdsView_Previews: PreviewProvider {
    static var previews: some View {
        RemoveAdsView()
    }
}
