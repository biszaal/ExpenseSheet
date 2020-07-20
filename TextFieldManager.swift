//
//  TextFieldManager.swift
//  ExpenseSheet
//
//  Created by Bishal Aryal on 20/7/16.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI

class TextFieldManager: ObservableObject
{
    let charLimit: Int
    
    init(charLimit: Int)
    {
        self.charLimit = charLimit
    }
    
    @Published var text = "" {
        didSet
        {
            if text.count > charLimit && oldValue.count <= charLimit
            {
                text = oldValue
            }
        }
    }
}
