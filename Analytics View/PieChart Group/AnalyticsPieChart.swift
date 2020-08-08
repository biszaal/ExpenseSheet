import SwiftUI
import Charts

struct AnalyticsPieChart: UIViewControllerRepresentable
{
    var year: Int
    var month: Int
    var kind: String
    
    init(year: Int, month: Int, kind: String)
    {
        self.year = year
        self.month = month
        self.kind = kind
    }
    
    func makeUIViewController(context: Context) -> UIViewController
    {
        let view = PieChartUIKit(year: self.year, month: self.month, kind: self.kind)
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context)
    {
        
    }
}
