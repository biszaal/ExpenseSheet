import SwiftUI

struct WillChart: View
{
    @State var infoView: Bool = false
    
    var body: some View
    {
        ZStack(alignment: .bottomTrailing)
        {
            VStack(alignment: .leading)
            {
                Spacer()
                
                if !infoView
                {
                    ChartView(kinds: ["need", "want"])
                        .frame(height: UIScreen.main.bounds.width / 3.5)
                    
                    Spacer()
                    
                    
                    VStack(alignment: .leading)
                    {
                        Text("Necessity")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        HStack
                            {
                                Rectangle()
                                    .fill(Color.init(red: 255 / 255, green: 150 / 255, blue: 50 / 255))
                                    .frame(width: 10, height: 10)
                                
                                Text("Want")
                                    .fixedSize(horizontal: true, vertical: false)
                        }
                        HStack
                            {
                                Rectangle()
                                    .fill(Color.init(red: 108 / 255, green: 215 / 255, blue: 80 / 255))
                                    .frame(width: 10, height: 10)
                                
                                Text("Need")
                                    .fixedSize(horizontal: true, vertical: false)
                        }
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
            .background(Color.gray.opacity(0.2))
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
