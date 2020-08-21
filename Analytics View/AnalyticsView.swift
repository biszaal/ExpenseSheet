import SwiftUI
import CoreData

struct AnalyticsView: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    
    @State var currentTab = "category"
    
    @State var year: Int = Calendar.current.component(.year, from: Date())
    @State var month: Int = Calendar.current.component(.month, from: Date())
    
    @State var datePickerView: Bool = false
    
    @State var refreshPage: Bool = false
    
    var body: some View
    {
        VStack
            {
                HStack
                    {
                        Text("Analytics")
                            .font(.system(size: 30, design: .serif))
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .colorInvert()
                        
                }
                .padding()
                .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! - 10)
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                .background(Color.init(red: 38 / 255, green: 100 / 255, blue: 115 / 255))
                    .animation(nil)     //fix animation bug
                
                Group
                    {
                        if !refreshPage         // this will turn on and off to refesh the page
                        {
                            
                            VStack
                                {
                                    HStack
                                        {
                                            Button(action: {
                                                if self.month == 1
                                                {
                                                    self.year -= 1
                                                    self.month = 12
                                                }
                                                else {
                                                    self.month -= 1
                                                }
                                                
                                                self.refreshPage = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {   // wait
                                                    self.refreshPage = false
                                                }
                                            })
                                            {
                                                HStack
                                                    {
                                                        Image(systemName: "chevron.left")
                                                        Text("Previous")
                                                }
                                            }
                                            .padding(.horizontal)
                                            
                                            Spacer()
                                            
                                            Text("\(String(year)) \(MonthView(year: year).monthToString(month: month))")
                                                .font(.body)
                                                .fontWeight(.heavy)
                                            
                                            Spacer()
                                            
                                            if self.month == Calendar.current.component(.month, from: Date()) && self.year == Calendar.current.component(.year, from: Date())
                                            {   // this will prevent you to go to the future months and the "next" button will not apper
                                                Text("     ")  // the empty space is to align text
                                                    .padding(.horizontal)
                                            } else
                                            {
                                                Button(action: {
                                                    if self.month == 12
                                                    {
                                                        self.year += 1
                                                        self.month = 1
                                                    }
                                                    else {
                                                        self.month += 1
                                                    }
                                                    
                                                    self.refreshPage = true
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {   // wait
                                                        self.refreshPage = false
                                                    }
                                                })
                                                {
                                                    HStack
                                                        {
                                                            Text("Next")
                                                            Image(systemName: "chevron.right")
                                                    }
                                                }
                                                .padding(.horizontal)
                                            }
                                    }
                                    
                                    HStack
                                        {
                                            
                                            MainWillChart(year: self.year, month: self.month)
                                            
                                            MainTypeChart(year: self.year, month: self.month)
                                            
                                    }
                                    .padding(.horizontal)
                                    
                                    VStack
                                        {
                                            Picker(selection: $currentTab, label: Text(""))
                                            {
                                                Text("Categories").tag("category")
                                                Text("Payment Methods").tag("methods")
                                            }
                                            .padding()
                                            .pickerStyle(SegmentedPickerStyle())
                                            
                                            Group
                                                {
                                                    if currentTab == "category"
                                                    {
                                                        CategoriesView(year: self.year, month: self.month)
                                                            .transition(AnyTransition.move(edge: .leading))
                                                    }
                                                    else if currentTab == "methods"
                                                    {
                                                        MethodsView(year: self.year, month: self.month)
                                                    }
                                            }
                                            .padding()
                                            .frame(width: UIScreen.main.bounds.width / 1.05, height: UIScreen.main.bounds.height / 3.3)
                                            .background(Color(UIColor.secondarySystemBackground))
                                            .cornerRadius(10)
                                            .shadow(radius: 5)
                                    }
                                    .padding()
                                    .animation(.easeInOut)
                            }
                        }
                }
                Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.horizontal)
    }
    
    func listOfYears() -> [Int]
    {
        var years: [Int] = []
        for each in self.transactionData
        {
            if !years.contains(Int(each.year))
            {
                years.append(Int(each.year))
            }
        }
        return years.sorted(by: >)
    }
    
    func listOfMonths(year: Int) -> [Int]
    {
        var months: [Int] = []
        for each in self.transactionData
        {
            if each.year == year {
                if !months.contains(Int(each.month))
                {
                    months.append(Int(each.month))
                }
            }
        }
        return months.sorted()
    }
}
