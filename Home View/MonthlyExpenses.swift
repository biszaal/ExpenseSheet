import SwiftUI
import CoreData

struct MonthlyExpenses: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    
    var year: Int
    
    @State var heightOfBar:CGFloat = 0      // used for animation
    
    var body: some View
    {
        VStack
            {
                HStack(alignment: .bottom)
                {
                    VStack(spacing: UIScreen.main.bounds.height / 33)
                    {
                        ForEach(0..<5)
                        { each in
                            Text(self.tooLongInt(number: Float(self.getMaxPriceOfYear() - ((self.getMaxPriceOfYear() / 4) * each))))
                                .rotationEffect(.degrees(-45))
                                .frame(height: UIScreen.main.bounds.height / 40)
                        }
                        
                    }
                    .padding(.vertical)
                    .foregroundColor(.primary)
                    .font(.system(size: 10))
                    .fixedSize(horizontal: true, vertical: false)
                    
                    Divider()
                    
                    ScrollView(.horizontal, showsIndicators: false)
                    {
                        HStack(alignment: .bottom, spacing: 30)
                        {
                            ForEach(0..<12, id: \.self)
                            { eachMonth in
                                
                                VStack
                                    {
                                        Spacer()
                                        
                                        Text(String(self.listOfMonthlyExpenses()[eachMonth].description))
                                            .font(.system(size: 12, design: .serif))
                                            .fontWeight(.bold)
                                            .rotationEffect(.degrees(-45))
                                            .fixedSize(horizontal: true, vertical: false)
                                        
                                        Capsule()
                                            .frame(width: 5, height: (UIScreen.main.bounds.height * CGFloat(self.listOfMonthlyExpenses()[eachMonth] / Float(self.getMaxPriceOfYear() + 1)) / 4.5) * self.heightOfBar)
                                        
                                        Text(self.monthToString(month: eachMonth + 1))
                                            .font(.system(size: 12, design: .serif))
                                            .fixedSize(horizontal: true, vertical: false)
                                        .animation(nil)
                                }
                            }
                        .onAppear
                                {
                                    withAnimation(.linear(duration: 0.5))
                                    {
                                    self.heightOfBar = 1
                                    }
                            }
                        }
                    }
                    
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 3)
                .foregroundColor(Color.init(red: 230 / 255, green: 95 / 255, blue: 85 / 255).opacity(0.8))
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(10)
                .shadow(radius: 5)
                
                Spacer()
                    .frame(height: UIScreen.main.bounds.height / 50)
        }
    }
    
    func listOfMonthlyExpenses() -> [Float]
    {
        var list: [Float] = []
        
        for everymonth in 1...12
        {
            var totalMonth: Float = 0
            for each in transactionData
            {
                if each.month == everymonth && each.year == self.year
                {
                    totalMonth += each.price
                }
            }
            list.append(totalMonth)
        }
        
        return list
    }
    
    func getMaxPriceOfYear() -> Int
    {
        var max: Float = listOfMonthlyExpenses()[0]
        
        for each in listOfMonthlyExpenses()
        {
            if each > max {
                max = each
            }
        }
        
        let roundUp = roundUpMaxPrice(price: Int(max))
        
        return Int(round(max / Float(roundUp)) * Float(roundUp))
    }
    
    // This function is used to get the maximum value for y axis in graph
    func roundUpMaxPrice(price: Int) -> Int {
        var num = price
        var count = 0
        while num > 10
        {
            var _ = price % 10
            count += 1
            num = num / 10
        }
        
        return Int(pow(Double(10),Double(count))) * (num + 1)
    }
    
    func monthToString(month: Int) -> String  //convert Integer months to string
    {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        return months[month - 1]
    }
    
    func tooLongInt(number: Float) -> String// this will reduce too long integers for ex: 10,000 -> 10 k
    {
        var result: String = String(number)
        if number > 999
        {
            result = String((number / 1000).description) + "k"
        }
        
        if number > 1000000
        {
            result = String((number / 1000).description) + "m"
        }
        
        return result
    }
}

