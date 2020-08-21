import Charts
import CoreData

class PieChartUIKit: UIViewController, ChartViewDelegate
{
    var year: Int
    var month: Int
    var kind: String
    
    init (year: Int, month: Int, kind: String) {
        self.year = year
        self.month = month
        self.kind = kind
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var pieChart = PieChartView()
    var values: [PieChartDataEntry] = []
    
    var chartColors = ChartColorTemplates.joyful()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        fetch()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        pieChart.frame = CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        view.addSubview(pieChart)
        
        let set = PieChartDataSet(entries: values, label: "")
        set.colors = chartColors
        set.drawValuesEnabled = false
        set.selectionShift = 0
        
        let data = PieChartData(dataSet: set)
        pieChart.data = data
        pieChart.sizeToFit()
        
        pieChart.minOffset = 0
        pieChart.drawEntryLabelsEnabled = !pieChart.drawEntryLabelsEnabled
        pieChart.chartDescription?.enabled = false
        pieChart.drawHoleEnabled = false
        pieChart.rotationAngle = 0
        pieChart.rotationEnabled = false
        pieChart.isUserInteractionEnabled = false
        
        pieChart.animate(xAxisDuration: 1, yAxisDuration: 1)
    }
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func fetch()
    {
        let fetchRequest: NSFetchRequest<TransactionData> = TransactionData.getTransactionData()
        
        do
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let transactionData = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            print("Number of results: \(transactionData.count)")
            
            if self.kind.lowercased() == "type"
            {
                var totalCreditValue:Float = 0
                var totalDebitValue:Float = 0
                
                for each in transactionData
                {
                    if each.type?.lowercased() == "credit" && each.year == year && each.month == self.month
                    {
                        totalCreditValue += each.price
                    }
                }
                for each in transactionData
                {
                    if each.type?.lowercased() == "debit" && each.year == year && each.month == self.month
                    {
                        totalDebitValue += each.price
                    }
                }
                
                chartColors = ChartColorTemplates.joyful()
                
                values.append(PieChartDataEntry(value: Double(totalCreditValue.rounded()), label: "Credit"))
                values.append(PieChartDataEntry(value: Double(totalDebitValue.rounded()), label: "Debit"))
            }
                
            else if self.kind.lowercased() == "will"
            {
                var totalNeedValue:Float = 0
                var totalWantValue:Float = 0
                
                for each in transactionData
                {
                    if each.will?.lowercased() == "need" && each.year == year && each.month == self.month
                    {
                        totalNeedValue += each.price
                    }
                }
                for each in transactionData
                {
                    if each.will?.lowercased() == "want" && each.year == year && each.month == self.month
                    {
                        totalWantValue += each.price
                    }
                }
                
                chartColors = ChartColorTemplates.material()
                
                values.append(PieChartDataEntry(value: Double(totalNeedValue.rounded()), label: "Need"))
                values.append(PieChartDataEntry(value: Double(totalWantValue.rounded()), label: "Want"))
            }
            else {
                print("Error in pieChart kind input")
            }
        }
        catch {
            print(error)
        }
    }
}
