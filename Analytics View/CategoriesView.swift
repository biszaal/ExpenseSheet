import SwiftUI
import CoreData

struct CategoriesView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    @FetchRequest(fetchRequest: CategoriesData.getCategoriesData()) var categoriesData: FetchedResults<CategoriesData>
    
    @State var lengthOfBar: CGFloat = 0      // used for animation
    
    var body: some View
    {
        ScrollView(showsIndicators: false)
        {
            VStack (alignment: .leading, spacing: UIScreen.main.bounds.height / 50)
            {
                ForEach(self.categoriesData)
                { data in
                    HStack
                        {
                            Text(data.category ?? "Empty")
                                .font(.system(size: 15))
                                .lineLimit(1)
                                .animation(nil)
                            
                            Spacer()
                            
                            Capsule()
                                .frame(width: (UIScreen.main.bounds.width * (CGFloat(self.getPriceOfCategory(category: data.category!)) / CGFloat(self.maxPrice() + 1))) / 2.7 * self.lengthOfBar, height: 5, alignment: .trailing)
                                .foregroundColor(Color.init(red: Double.random(in: 100..<255) / 255, green: Double.random(in: 100..<255) / 255, blue: Double.random(in: 50..<200) / 255))
                            
                            Text(self.tooLongInt(number: Float(self.getPriceOfCategory(category: data.category!))))
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
        var eachCategoryTotal: Int = 0
        
        for each in self.categoriesData
        {
            eachCategoryTotal = getPriceOfCategory(category: each.category!)
            
            if eachCategoryTotal > maxPrice
            {
                maxPrice = eachCategoryTotal
            }
        }
        return maxPrice
    }
    
    func getPriceOfCategory(category: String) -> Int
    {
        var price: Int = 0
        
        for each in self.transactionData
        {
            if each.category == category
            {
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

