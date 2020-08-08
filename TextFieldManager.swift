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
