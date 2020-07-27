import SwiftUI
import Charts

struct MonthlyExpenses: UIViewControllerRepresentable
{
    var year: Int
    
    init(year: Int)
    {
        self.year = year
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let view = MonthlyExpensesUIKit(year: self.year)
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
