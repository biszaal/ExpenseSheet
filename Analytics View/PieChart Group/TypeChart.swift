//
//  TypeChart.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/15/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI

struct TypeChart: View
{
    var body: some View
    {
        VStack(alignment: .leading)
        {
            ChartView(kinds: ["credit", "debit"])
                .frame(height: UIScreen.main.bounds.width / 3.5)
            
            Spacer()
            
            Text("Payment Type")
                .font(.headline)
                .fontWeight(.bold)
            
            VStack (alignment: .leading)
                {
                HStack
                    {
                        Rectangle()
                            .fill(Color.init(red: 90 / 255, green: 126 / 255, blue: 214 / 255))
                            .frame(width: 10, height: 10)
                        
                        Text("Debit or Cash")
                            .fixedSize(horizontal: true, vertical: false)
                }
                HStack
                    {
                        Rectangle()
                            .fill(Color.init(red: 255 / 255, green: 100 / 255, blue: 100 / 255))
                            .frame(width: 10, height: 10)
                        
                        Text("Credit")
                            .fixedSize(horizontal: true, vertical: false)
                }
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width / 2.1, height: UIScreen.main.bounds.height / 3.2)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
