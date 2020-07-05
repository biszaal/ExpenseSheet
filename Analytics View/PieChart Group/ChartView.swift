//
//  ChartView.swift
//  Expense Sheet
//
//  Created by Bishal Aryal on 6/1/20.
//  Copyright © 2020 Bishal Aryal. All rights reserved.
//

import SwiftUI
import CoreData
import CloudKit

struct ChartView: View
{
    
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: TransactionData.getTransactionData()) var transactionData: FetchedResults<TransactionData>
    
    var kinds: [String]
    
    init(kinds: [String])
    {
        self.kinds = kinds
    }
    
    var body: some View
    {
        
        GeometryReader
            {
                geometry in
                
                ZStack
                    {
                        
                        ForEach (0..<self.total().count, id: \.self)
                        { i in
                            
                            DrawShape(center: CGPoint(x: geometry.frame(in: .global).width / 2, y: geometry.frame(in: .global).height / 2), index: i, listtotalData: self.total())
                        }
                }
        }
        .frame(height: 360)
    }
    
    
    func total() -> [totalData]
    {
        
        var totalValue: Array<totalData> = []
        
        for kind in kinds
        {
            if kind == "need"
            {
                totalValue.append(totalData(name: kind, price: toDegree(value: totalWill(kind: "need")), color: Color.init(red: 108 / 255, green: 215 / 255, blue: 80 / 255)))
            }
            if kind == "want"
            {
                totalValue.append(totalData(name: kind, price: toDegree(value: totalWill(kind: "want")), color: Color.init(red: 255 / 255, green: 150 / 255, blue: 50 / 255)))
            }
            if kind == "credit"
            {
                totalValue.append(totalData(name: kind, price: toDegree(value: totalType(kind: "credit")), color: Color.init(red: 255 / 255, green: 100 / 255, blue: 100 / 255)))
            }
            if kind == "debit"
            {
                totalValue.append(totalData(name: kind, price: toDegree(value: totalType(kind: "debit")), color: Color.init(red: 90 / 255, green: 126 / 255, blue: 214 / 255)))
            }
        }
        return totalValue
    }
    
    func toDegree(value: Float) -> Float
    {
        var total:Float = 0
        
        for kind in kinds
        {
            if kind == "need"
            {
                total += totalWill(kind: "need")
            }
            if kind == "want"
            {
                total += totalWill(kind: "want")
            }
            if kind == "credit"
            {
                total += totalType(kind: "credit")
            }
            if kind == "debit"
            {
                total += totalType(kind: "debit")
            }
        }
        
        return (value / total) * 100
    }
    
    
    
    func totalWill (kind: String) -> Float
    {
        var totalWillValue:Float = 0
        
        for each in transactionData
        {
            if each.will?.lowercased() == kind
            {
                totalWillValue += each.price
            }
        }
        
        return totalWillValue
    }
    
    func totalType (kind: String) -> Float
    {
        var totalTypeValue:Float = 0
        
        for each in transactionData
        {
            if each.type?.lowercased() == kind
            {
                totalTypeValue += each.price
            }
        }
        
        return totalTypeValue
    }
    
    struct DrawShape: View
    {
        var center: CGPoint
        var index: Int
        var listtotalData: [totalData]
        
        var body: some View
        {
            
            Path
                { path in
                
                path.move(to: self.center)
                
                path.addArc(center: self.center, radius: UIScreen.main.bounds.height / 15, startAngle: .init(degrees: self.getDegreeFrom()), endAngle: .init(degrees: self.getDegreeTo()), clockwise: false)
                path.closeSubpath()
                
            }
            .fill(listtotalData[index].color)
            
        }
        
        
        func getDegreeFrom() -> Double
        {
            if index == 0 {
                return 0
            } else {
                
                var temp: Double = 0
                
                for i in 0...index - 1
                {
                    temp += Double(listtotalData[i].price / 100) * 360
                }
                
                return temp
            }
        }
        
        
        func getDegreeTo() -> Double
        {
            var temp: Double = 0
            
            for i in 0...index {
                temp += Double(listtotalData[i].price / 100) * 360
            }
            
            return temp
        }
        
    }
    
}
