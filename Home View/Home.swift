import SwiftUI
import CoreData

struct Home: View
{
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    
    @State var showTransactionView = false
    
    @State var yearStat = Calendar.current.component(.year, from: Date())
    @State var monthlyStatView = true
    
    @State var plusSize: CGFloat = 150 // for animation
    
    @State var refreshPage: Bool = false        //refresh
    
    @State var backgroundOpacity: Double = 0
    
    @State var hideAds: Bool = UserDefaults.standard.bool(forKey: "ads_removed")
    
    var body: some View
    {
        
        ZStack
            {
                VStack(spacing: 0)
                {
                    HStack
                        {
                            Text("Expense Sheet")
                                .font(.system(size: 30, design: .serif))
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .colorInvert()
                            
                            Spacer()
                            
                            Button(action: {        // first start animation and after 0.3 second show the background
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                                {
                                    self.backgroundOpacity = 0.4
                                }
                                
                                withAnimation
                                    {
                                        self.showTransactionView.toggle()
                                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                                }
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 30))
                                    .foregroundColor(.primary)
                                    .colorInvert()
                                    .background(
                                        Circle()
                                            .fill(Color(UIColor.systemBlue))
                                            .padding()
                                            .frame(width: self.plusSize, height: self.plusSize)
                                )
                                
                                    .shadow(radius: 10)
                                    .padding(.horizontal)
                            }
                            .onAppear()
                                {
                                    withAnimation(.spring(response: 1, dampingFraction: 0.4, blendDuration: 0.5))
                                    {
                                        self.plusSize = 80
                                    }
                            }
                            .onDisappear()
                                {
                                    self.plusSize = 150
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
                            .shadow(radius: 5)
                        
                        VStack(spacing: 0)
                        {
                            Button(action: {
                                withAnimation(.default)
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
                                            .cornerRadius(30)
                                }
                            }
                            .font(.system(size: 20, design: .serif))
                            .padding()
                            
                            Group
                                {
                                    if monthlyStatView
                                    {
                                        MonthlyExpenses(year: self.yearStat)
                                    }
                                    else
                                    {
                                        VStack(spacing: 0)
                                        {
                                            Picker(selection: $yearStat, label: Text("")) {
                                                ForEach(self.listOfYears(), id: \.self) { eachYear in
                                                    Text(String(eachYear))
                                                }
                                            }
                                            .labelsHidden()
                                            .frame(height: UIScreen.main.bounds.height / 4)
                                            
                                            Button(action: {
                                                withAnimation(.default)
                                                {
                                                    self.monthlyStatView = true
                                                }
                                            }) {
                                                Text("Done")
                                                    .font(.system(size: 20, design: .serif))
                                                    .foregroundColor(.white)
                                                    .padding()
                                                    .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.height / 20)
                                                    .background(Color.init(red: 254 / 255, green: 95 / 255, blue: 85 / 255).opacity(0.8))
                                                    .cornerRadius(30)
                                                    .shadow(radius: 20)
                                            }
                                        }
                                        .transition(.move(edge: .bottom))
                                    }
                            }
                            .padding()
                            .frame(width: UIScreen.main.bounds.width / 1.05, height: UIScreen.main.bounds.height / 3.1)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            
                        }
                    }
                    
                    Spacer()
                    
                    if !hideAds
                    {
                        GoogleAdView(bannerId: "ca-app-pub-9776815710061950/1924102059")
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 18)
                            .padding(.top)
                    }
                }
                
                
                if self.showTransactionView
                {
                    GeometryReader
                        { _ in
                        NewTransactionView(showTransactionView: self.$showTransactionView)
                            .offset(y: 50)
                    }
                    .padding(.bottom, UIScreen.main.bounds.height / 3.5)
                    .background(
                        Color.black.opacity(self.backgroundOpacity).animation(.easeInOut(duration: 0.2))
                            .animation(nil)
                            .onTapGesture
                            {     // first remove background and start animation
                                self.backgroundOpacity = 0
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
                                {
                                    withAnimation {
                                        self.showTransactionView.toggle()
                                    }
                                }
                    })
                        .zIndex(1)  // put view always on the top of zStack
                        
                        .transition(AnyTransition.scale(scale: 0, anchor: .topTrailing).combined(with: AnyTransition.opacity))
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
