import Foundation
import SwiftUI

struct CurrencyData: Codable, Identifiable {
    
    var id = UUID()
    var symbol_native: String
    var code: String
    var decimal_digits: Int
}


