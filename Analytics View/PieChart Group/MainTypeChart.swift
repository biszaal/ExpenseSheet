import SwiftUI

struct MainTypeChart: View
{
    @State var infoView: Bool = false
    
    var year: Int
    var month: Int
    
    init(year: Int, month: Int)
    {
        self.year = year
        self.month = month
    }
    
    var body: some View
    {
        ZStack(alignment: .bottomTrailing)
        {
            VStack(alignment: .leading)
            {
                Spacer()
                
                if !infoView
                {
                    VStack
                        {
                            Text("Payment Type")
                            .font(.system(size: 15, design: .serif))
                            .fontWeight(.bold)
                            AnalyticsPieChart(year: self.year, month: self.month, kind: "type")
                    }
                } else {
                    ScrollView(showsIndicators: false)
                        {
                            Text("This chart will helps you keep track of purchases you made using credit cards or debit cards or cash. According to experts, people tend to spend more while using credit card over debit card or cash.")
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                                .padding(.bottom)
                                .rotation3DEffect(self.infoView ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
                    }
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width / 2.1)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            .shadow(radius: 5)
            .rotation3DEffect(self.infoView ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
            
            // MARK: - info button
            Button(action: {
                withAnimation(.linear(duration: 0.5))
                {
                    self.infoView.toggle()
                }
            })
            {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 15))
                    .padding()
                    .foregroundColor(.secondary)
                    .frame(alignment: .topTrailing)
            }
        }
    }
}
