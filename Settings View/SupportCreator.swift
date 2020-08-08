//
//  SupportCreator.swift
//  ExpenseSheet
//
//  Created by Bishal Aryal on 20/8/1.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI

struct SupportCreator: View {
    var body: some View {
        List
            {
                Button(action:
                    {
                        UIApplication.shared.open(URL(string: "https://www.patreon.com/biszaal/")!)
                }) {
                    HStack
                        {
                            Text("Patreon")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                    }
                }
                
                Button(action:
                    {
                        UIApplication.shared.open(URL(string: "https://www.youtube.com/channel/UC3KAFgk1UWumCN_z9qXcSdA/")!)
                }) {
                    HStack
                        {
                            Text("YouTube")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                    }
                }
                
                Button(action:
                    {
                        UIApplication.shared.open(URL(string: "https://www.instagram.com/biszaalapps/")!)
                }) {
                    HStack
                        {
                            Text("Instagram")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                    }
                }
        }
    }
}
