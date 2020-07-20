import SwiftUI

struct TypeChart: View
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
                    ChartView(kinds: ["credit", "debit"])
                        .frame(height: UIScreen.main.bounds.width / 3.5)
                    
                    Spacer()
                    
                    Text("Payment Type")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    VStack (alignment: .leading)
                    {
                        HStack
                            {
                                Rectangle()
                                    .fill(Color.init(red: 90 / 255, green: 126 / 255, blue: 214 / 255))
                                    .frame(width: 10, height: 10)
                                
                                Text("Debit or Cash")
                                    .fixedSize(horizontal: true, vertical: false)
                        }
                        HStack
                            {
                                Rectangle()
                                    .fill(Color.init(red: 255 / 255, green: 100 / 255, blue: 100 / 255))
                                    .frame(width: 10, height: 10)
                                
                                Text("Credit")
                                    .fixedSize(horizontal: true, vertical: false)
                        }
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
