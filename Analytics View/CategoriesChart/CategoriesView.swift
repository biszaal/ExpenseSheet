import SwiftUI
import Charts

struct CategoriesView: UIViewControllerRepresentable
{
    var year: Int
    var month: Int
    
    init(year: Int, month: Int)
    {
        self.year = year
        self.month = month
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let view = HorizontalBarChartUIKit(year: self.year, month: self.month, kind: "category")
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
