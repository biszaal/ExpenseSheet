//
//  AnalyticsView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/3/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI

struct AnalyticsView: View {
    var body: some View {
        
        VStack
            {
                Text("Anylytics")
                    .font(.system(size: 30, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! + 10)
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                    .background(Color.init(red: 38 / 255, green: 100 / 255, blue: 115 / 255))
                
                
                HStack
                    {
                        VStack(alignment: .leading)
                        {
                            ChartView(kinds: ["need", "want"])
                                .frame(height: UIScreen.main.bounds.width / 3.5)
                            
                            Text("Will")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            HStack {
                                HStack
                                    {
                                        Rectangle()
                                            .fill(Color.init(red: 255 / 255, green: 115 / 255, blue: 0 / 255))
                                            .frame(width: 10, height: 10)
                                        
                                        Text("Want")
                                            .fixedSize(horizontal: true, vertical: false)
                                }
                                HStack
                                    {
                                        Rectangle()
                                            .fill(Color.init(red: 82 / 255, green: 215 / 255, blue: 38 / 255))
                                            .frame(width: 10, height: 10)
                                        
                                        Text("Need")
                                            .fixedSize(horizontal: true, vertical: false)
                                }
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.09, maxHeight: UIScreen.main.bounds.height / 3.5)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        
                        VStack(alignment: .leading)
                        {
                            ChartView(kinds: ["credit", "debit"])
                            .frame(height: UIScreen.main.bounds.width / 3.5)
                            
                            Text("Type")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            HStack {
                                HStack
                                    {
                                        Rectangle()
                                            .fill(Color.init(red: 0 / 255, green: 126 / 255, blue: 214 / 255))
                                            .frame(width: 10, height: 10)
                                        
                                        Text("Debit")
                                            .fixedSize(horizontal: true, vertical: false)
                                }
                                HStack
                                    {
                                        Rectangle()
                                            .fill(Color.init(red: 255 / 255, green: 0 / 255, blue: 0 / 255))
                                            .frame(width: 10, height: 10)
                                        
                                        Text("Credit")
                                            .fixedSize(horizontal: true, vertical: false)
                                }
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .frame(maxWidth: UIScreen.main.bounds.width / 1.09, maxHeight: UIScreen.main.bounds.height / 3.5)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        
                }
                .frame(maxWidth: UIScreen.main.bounds.width / 1.09)
                
                Spacer()
        }
        .background(LinearGradient(gradient: .init(colors: [.blue,.white]), startPoint: .top, endPoint: .bottom).opacity(0.5))
        .edgesIgnoringSafeArea(.all)
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
