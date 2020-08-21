import UIKit
import Charts
import CoreData
import Foundation

class HorizontalBarChartUIKit: UIViewController, ChartViewDelegate
{
    var year: Int
    var month: Int
    var kind: String
    
    init (year: Int, month: Int, kind: String)
    {
        self.year = year
        self.month = month
        self.kind = kind
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    // for bottom label
    var listOfkind: [String] = []
    
    lazy var barChart = HorizontalBarChartView()
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
        set.colors = ChartColorTemplates.colorful()
        set.drawValuesEnabled = true
        
        let data = BarChartData(dataSet: set)
        barChart.data = data
        
        barChart.highlighter = nil
        
        barChart.leftAxis.drawGridLinesEnabled = false
        barChart.leftAxis.spaceBottom = 0.0
        
        barChart.rightAxis.enabled = false
        
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.labelRotationAngle = -45
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:listOfkind)
        barChart.xAxis.labelCount = listOfkind.count
        
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
    func fetch(){
        let fetchRequest: NSFetchRequest<TransactionData> = TransactionData.getTransactionData()
        
        do
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let transactionData = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            print("Number of results: \(transactionData.count)")
            
            if kind == "category"
            {
                var listOfCategories: [String] = []
                
                for each in transactionData
                {
                    if !listOfCategories.contains(each.category ?? "Unknown") && each.year == self.year && each.month == self.month
                    {
                        listOfCategories.append(each.category ?? "Unknown")
                    }
                }
                
                if listOfCategories.isEmpty
                {
                    listOfCategories.append("Empty")
                }
                
                for index in 0..<listOfCategories.count
                {
                    var totalCategory: Float = 0
                    
                    for each in transactionData
                    {
                        if each.category == listOfCategories[index] && each.year == self.year && each.month == self.month
                        {
                            totalCategory += each.price
                        }
                    }
                    listOfkind = listOfCategories.sorted()
                    
                    yValues.append(BarChartDataEntry(x: Double(index), y: Double(totalCategory.rounded()), data: listOfCategories[index]))
                }
            }
            else if kind == "method"
            {
                var listOfMethods: [String] = []
                
                for each in transactionData
                {
                    if !listOfMethods.contains(each.method ?? "Unknown") && each.year == self.year && each.month == self.month
                    {
                        listOfMethods.append(each.method ?? "Unknown")
                    }
                }
                
                if listOfMethods.isEmpty
                {
                    listOfMethods.append("Empty")
                }
                
                for index in 0..<listOfMethods.count
                {
                    var totalMethod: Float = 0
                    
                    for each in transactionData
                    {
                        if each.method == listOfMethods[index] && each.year == self.year && each.month == self.month
                        {
                            totalMethod += each.price
                        }
                    }
                    listOfkind = listOfMethods.sorted()
                    
                    yValues.append(BarChartDataEntry(x: Double(index), y: Double(totalMethod.rounded()), data: listOfMethods[index]))
                }
            }
            else
            {
                print("Error in kind input HorizontalBarUIKit")
            }
        }
        catch {
            print(error)
        }
    }
    
}
