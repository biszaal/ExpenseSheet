//
//  Home.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 5/30/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI
import CloudKit
import CoreData

struct Home: View {
    
    @State var showTransactionView = false
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("Expense Sheet")
                    .font(.system(size: 30, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! + 10)
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                    .background(Color.init(red: 38 / 255, green: 100 / 255, blue: 115 / 255))
                
                Spacer()
                    .frame(height: UIScreen.main.bounds.height / 50)
                
                Button(action: {
                    
                    withAnimation {
                        self.showTransactionView.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add a new Transaction")
                    }
                    .font(.system(size: 20, design: .serif))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.init(red: 55 / 255, green: 50 / 255, blue: 150 / 255))
                    .cornerRadius(100)
                    
                }
                
                    
                    RecentDataListView()
                
                Spacer()
                
            }
                
            .background(LinearGradient(gradient: .init(colors: [.blue,.white]), startPoint: .top, endPoint: .bottom).opacity(0.5))
            .edgesIgnoringSafeArea(.all)
            
            if self.showTransactionView {
                GeometryReader {
                    _ in
                    
                    NewTransactionView()
                }
                .background(
                    Color.black.opacity(0.6)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                
                                self.showTransactionView.toggle()
                            }
                    }
                )
            }
            
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
