import SwiftUI
import CoreData

struct MethodsView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    @FetchRequest(fetchRequest: CreditCardsData.getCreditCardsData()) var creditCardsData: FetchedResults<CreditCardsData>
    @FetchRequest(fetchRequest: DebitCardsData.getDebitCardsData()) var debitCardsData: FetchedResults<DebitCardsData>
    
    @State var lengthOfBar: CGFloat = 0
    
    var body: some View
    {
        ScrollView(showsIndicators: false)
        {
            VStack (alignment: .leading, spacing: UIScreen.main.bounds.height / 50)
            {
                Section(header:
                    Text("Credit Cards")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary))
                {
                    ForEach(self.creditCardsData)
                    { data in
                        HStack
                            {
                                Text(data.creditCards ?? "Empty")
                                    .font(.system(size: 15))
                                    .lineLimit(1)
                                    .animation(nil)
                                
                                Spacer()
                                
                                Capsule()
                                    .frame(width: (UIScreen.main.bounds.width * (CGFloat(self.getPriceOfMethods(method: data.creditCards!)) / CGFloat(self.maxPrice() + 1))) / 2.7 * self.lengthOfBar, height: 5)
                                    .foregroundColor(Color.init(red: Double.random(in: 100..<255) / 255, green: Double.random(in: 100..<255) / 255, blue: Double.random(in: 50..<200) / 255))
                                
                                Text(self.tooLongInt(number: Float(self.getPriceOfMethods(method: data.creditCards!))))
                                    .font(.system(size: 15))
                                    .frame(width: UIScreen.main.bounds.width / 8, alignment: .trailing)
                                    .animation(nil)
                        }
                    }
                    .onAppear
                        {
                            withAnimation(.linear(duration: 0.5))
                            {
                                self.lengthOfBar = 1
                            }
                    }
                }
                
                Spacer()
                    .frame(height: 10)
                
                Section(header:
                    Text("Debit Cards and Cash")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary))
                {
                    ForEach(self.debitCardsData)
                    { data in
                        HStack
                            {
                                Text(data.debitCards ?? "Empty")
                                    .font(.system(size: 15))
                                    .lineLimit(1)
                                    .animation(nil)
                                
                                Spacer()
                                
                                Capsule()
                                    .frame(width: (UIScreen.main.bounds.width * (CGFloat(self.getPriceOfMethods(method: data.debitCards!)) / CGFloat(self.maxPrice() + 1))) / 2.7 * self.lengthOfBar, height: 5, alignment: .trailing)
                                    .foregroundColor(Color.init(red: Double.random(in: 100..<255) / 255, green: Double.random(in: 100..<255) / 255, blue: Double.random(in: 50..<200) / 255))
                                
                                Text(self.tooLongInt(number: Float(self.getPriceOfMethods(method: data.debitCards!))))
                                    .font(.system(size: 15))
                                    .frame(width: UIScreen.main.bounds.width / 8, alignment: .trailing)
                                .animation(nil)
                        }
                    }
                    .onAppear
                        {
                            withAnimation(.linear(duration: 0.5))
                            {
                                self.lengthOfBar = 1
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    func maxPrice() -> Int
    {
        var maxPrice: Int = 0
        var eachMethodTotal: Int = 0
        
        for each in self.creditCardsData
        {
            eachMethodTotal = getPriceOfMethods(method: each.creditCards!)
            
            if eachMethodTotal > maxPrice
            {
                maxPrice = eachMethodTotal
            }
        }
        for each in self.debitCardsData
        {
            eachMethodTotal = getPriceOfMethods(method: each.debitCards!)
            
            if eachMethodTotal > maxPrice
            {
                maxPrice = eachMethodTotal
            }
        }
        
        return maxPrice
    }
    
    func getPriceOfMethods(method: String) -> Int
    {
        var price: Int = 0
        
        for each in self.transactionData {
            if each.method == method {
                price += Int(each.price)
            }
        }
        
        return price
    }
    
    func tooLongInt(number: Float) -> String// this will reduce too long integers for ex: 100,000 -> 10 k
    {
        var result: String = String(number)
        if number > 99999
        {
            result = String((number / 1000).description) + "k"
        }
        
        if number > 999999
        {
            result = String((number / 1000).description) + "m"
        }
        return result
    }
}

