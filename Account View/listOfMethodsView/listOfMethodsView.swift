//
//  listOfMethodsView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/7/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI

struct listOfMethodsView: View {
    var body: some View {
        Form
            {
                Section(header: Text("Credit Cards")) {
                    listOfCreditsView()
                }
                
                
                Section(header: Text("Debit Cards")) {
                    listOfDebitsView()
                }
        }
    }
}

struct listOfMethodsView_Previews: PreviewProvider {
    static var previews: some View {
        listOfMethodsView()
    }
}
