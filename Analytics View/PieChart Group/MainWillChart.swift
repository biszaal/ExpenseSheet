import SwiftUI

struct MainWillChart: View
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
                            Text("Necessity")
                                .font(.system(size: 15, design: .serif))
                                .fontWeight(.bold)
                            AnalyticsPieChart(year: self.year, month: self.month, kind: "will")
                    }
                }
                else {
                    ScrollView(showsIndicators: false)
                    {
                        Text("This chart will helps you keep track of purchases you make which are necessary such as food rent and which are not so necassary which can be anything that you can live and survive without. This is very crutial to prevent our overspending because sometime we tend to spend our money on unnecassary products. Exprets say we should spend 50% on Need, 30% on Want and rest on saving and investing.")
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
