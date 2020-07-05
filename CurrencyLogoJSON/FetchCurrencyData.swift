
import SwiftUI


class FetchCurrencyData: ObservableObject
{
    
    
    func fetchData (completionHandler: @escaping ([CurrencyData]) -> ())
    {
        
        guard let path = Bundle.main.path(forResource: "currencyFile", ofType: "json")else
        {
            return
        }
        let url = URL(fileURLWithPath: path)
        
        URLSession.shared.dataTask(with: url)
        { (data, response, err) in
            
            guard let data = data else
            {
                return
                
            }
            
            do
            {
                
                let fetch = try JSONDecoder().decode([CurrencyData].self, from: data)
                
                DispatchQueue.main.async
                    {
                    completionHandler(fetch)
                }
                
            }
                
            catch
            {
                print(error)
            }
        }
        .resume()
    }
    
}


