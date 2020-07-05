import SwiftUI

struct WillChart: View
{
    var body: some View
    {
        VStack(alignment: .leading)
        {
            ChartView(kinds: ["need", "want"])
                .frame(height: UIScreen.main.bounds.width / 3.5)
            
            Spacer()
            
            Text("Will")
                .font(.headline)
                .fontWeight(.bold)
            
            VStack(alignment: .leading)
            {
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
        .padding()
        .frame(width: UIScreen.main.bounds.width / 2.1, height: UIScreen.main.bounds.height / 3.2)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .shadow(radius: 5)
        
    }
}
