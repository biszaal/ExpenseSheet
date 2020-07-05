import SwiftUI
import Combine

class StoreData: ObservableObject
{
    
    @Published var currencyData: [CurrencyData] = []
    
    init()
    {
        fetchData()
    }
    
    func fetchData()
    {
        FetchCurrencyData().fetchData
            { (currencyData) in
                
            self.currencyData = currencyData
            
        }
    }
    
    
}
