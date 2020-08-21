import UIKit
import Charts
import CoreData
import Foundation

class MonthlyExpensesUIKit: UIViewController, ChartViewDelegate
{
    var year: Int
    
    init (year: Int) {
        self.year = year
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // for bottom label
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    lazy var barChart = BarChartView()
    var yValues: [BarChartDataEntry] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.fetch()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width / 2)
        barChart.center = view.center
        
        view.addSubview(barChart)
        
        let set = BarChartDataSet(entries: yValues, label: "")
        set.setColor(.init(red: 230 / 255, green: 95 / 255, blue: 85 / 255, alpha: 1))
        
        
        let data = BarChartData(dataSet: set)
        barChart.data = data
        
        barChart.highlighter = nil
        
        barChart.leftAxis.drawGridLinesEnabled = false
        barChart.leftAxis.spaceBottom = 0.0
        
        barChart.rightAxis.enabled = false
        
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.labelRotationAngle = -45
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        barChart.xAxis.labelCount = 12
        
        barChart.scaleYEnabled = false
        barChart.scaleXEnabled = false
        
        barChart.legend.enabled = false
        barChart.pinchZoomEnabled = false
        barChart.doubleTapToZoomEnabled = false
        barChart.drawValueAboveBarEnabled = true
        barChart.drawGridBackgroundEnabled = true
        barChart.backgroundColor = .clear
        barChart.gridBackgroundColor = .clear
        barChart.animate(yAxisDuration: 1, easingOption: .easeInOutQuart)
        barChart.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 3.5)
    }
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }

    // fetching core data and implimenting to the bar chart
    func fetch() {
        let fetchRequest: NSFetchRequest<TransactionData> = TransactionData.getTransactionData()
        
        do
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let transactionData = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            print("Number of results: \(transactionData.count)")
            
            var listOfMonthlyExpenses: [Float] = []
            
            for everymonth in 1...12
            {
                var totalMonth: Float = 0
                for each in transactionData
                {
                    if each.month == everymonth && each.year == self.year
                    {
                        totalMonth += each.price
                    }
                }
                listOfMonthlyExpenses.append(totalMonth)
                
                yValues.append(BarChartDataEntry(x: Double(everymonth - 1), y: Double(listOfMonthlyExpenses[everymonth - 1].rounded())))
            }
        }
        catch {
            print(error)
        }
    }
    
    
}
