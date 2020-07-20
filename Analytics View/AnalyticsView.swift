import SwiftUI

struct AnalyticsView: View
{
    @State var currentTab = "category"
    
    var body: some View
    {
        
        VStack()
            {
                Text("Analytics")
                    .font(.system(size: 30, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .colorInvert()
                    .padding()
                    .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! - 10)
                    .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                    .background(Color.init(red: 38 / 255, green: 100 / 255, blue: 115 / 255))

                
                VStack
                    {
                        HStack
                            {
                                WillChart()
                                
                                TypeChart()
                                
                        }
                        
                        Picker(selection: $currentTab, label: Text(""))
                        {
                            Text("Categories").tag("category")
                            Text("Payment Methods").tag("methods")
                        }
                        .padding()
                        .pickerStyle(SegmentedPickerStyle())
                        
                        if currentTab == "category"
                        {
                            CategoriesView()
                            .padding()
                        }
                        else if currentTab == "methods"
                        {
                            MethodsView()
                            .padding()
                        }
                }
        }
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.horizontal)
    }
}
