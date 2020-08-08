import SwiftUI
import CoreData

struct Home: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    
    @State var showTransactionView = false
    
    @State var yearStat = Calendar.current.component(.year, from: Date())
    @State var monthlyStatView = true
    
    @State var plusSize: CGFloat = 100 // for animation
    
    @State var refreshPage: Bool = false        //refresh
    
    var body: some View
    {
        
        ZStack
            {
                VStack
                    {
                        HStack
                            {
                                Text("Expense Sheet")
                                    .font(.system(size: 30, design: .serif))
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .colorInvert()
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    withAnimation
                                        {
                                            self.showTransactionView.toggle()
                                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                    }
                                }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 25))
                                        .foregroundColor(.primary)
                                    .colorInvert()
                                        .background(
                                            Circle()
                                                .fill(Color.blue)
                                                .padding()
                                                .frame(width: self.plusSize, height: self.plusSize)
                                    )
                                        .padding(.horizontal)
                                }
                                .onAppear()
                                    {
                                        withAnimation(.spring(response: 1, dampingFraction: 0.3, blendDuration: 0.3))
                                        {
                                            self.plusSize = 80
                                        }
                                }
                                .onDisappear()
                                    {
                                        self.plusSize = 100
                                }
                        }
                        .padding()
                        .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! - 10)
                        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                        .background(Color.init(red: 38 / 255, green: 100 / 255, blue: 115 / 255))
                        
                        if !self.refreshPage
                        {
                            RecentDataListView()
                                .cornerRadius(10)
                                .padding()
                                .frame(maxWidth: UIScreen.main.bounds.width)
                                .shadow(radius: 5)
                            
                            VStack
                                {
                                    Button(action: {
                                        withAnimation
                                            {
                                                self.monthlyStatView.toggle()
                                        }
                                    })
                                    {
                                        HStack
                                            {
                                                Text(String(yearStat))
                                                    .foregroundColor(.primary)
                                                Image(systemName: "chevron.down.square.fill")
                                                    .cornerRadius(.infinity)
                                        }
                                    }
                                    .font(.system(size: 20, design: .serif))
                                    .padding()
                                    
                                    if monthlyStatView
                                    {
                                        MonthlyExpenses(year: self.yearStat)
                                            .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 3.5)
                                            .cornerRadius(10)
                                            .shadow(radius: 5)
                                    }
                                    else
                                    {
                                        
                                        Picker(selection: $yearStat, label: Text("")) {
                                            ForEach(self.listOfYears(), id: \.self) { eachYear in
                                                Text(String(eachYear))
                                            }
                                        }
                                        .labelsHidden()
                                        .frame(maxHeight: UIScreen.main.bounds.height / 5)
                                        .padding()
                                        
                                        Button(action: {
                                            withAnimation
                                                {
                                                    self.monthlyStatView = true
                                            }
                                        }) {
                                            Text("Done")
                                                .font(.system(size: 20, design: .serif))
                                                .foregroundColor(.white)
                                                .padding()
                                                .frame(width: UIScreen.main.bounds.width / 4 , height: UIScreen.main.bounds.height / 20)
                                                .background(Color.init(red: 254 / 255, green: 95 / 255, blue: 85 / 255).opacity(0.8))
                                                .cornerRadius(20)
                                                .shadow(radius: 20)
                                        }
                                        Spacer()
                                            .frame(height: UIScreen.main.bounds.height / 40)
                                    }
                                    
                            }
                        }
                        
                        Spacer()
                        GoogleAdView(bannerId: "ca-app-pub-9776815710061950/1924102059")
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 18)
                }
                
                
                if self.showTransactionView
                {
                    GeometryReader
                        {
                            _ in
                            
                            NewTransactionView()
                    }
                    .background(
                        Color.black.opacity(0.6)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                withAnimation {
                                    self.showTransactionView.toggle()
                                }
                    })
                }
                
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
}
