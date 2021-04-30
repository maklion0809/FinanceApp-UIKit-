//
//  DiagramTableViewCell.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 19.01.2021.
//

import UIKit
import Charts

class DiagramTableViewCell: UITableViewCell {
    
    var track: [String] = []
    var money: [Double] = []
    var colors: [UIColor] = []
    var generalSum: Double = 0
    
    var infTransaction: [Transaction] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func updateChartData()  {
        for i in  0...infTransaction.count - 1{
            track.append(infTransaction[i].category.name)
            money.append(Double(infTransaction[i].sum) ?? 0.00)
            generalSum += Double(infTransaction[i].sum) ?? 0.00
            colors.append(infTransaction[i].category.color)
        }
        let chart = PieChartView(frame: self.bounds)
        chart.center.x = self.frame.width/2
        chart.center.y = self.frame.height/2
        

       var entries = [PieChartDataEntry]()
       for (index, value) in money.enumerated() {
           let entry = PieChartDataEntry()
           entry.y = value
           entry.label = track[index]
           entries.append( entry)
       }

        let set = PieChartDataSet( entries: entries, label: "")

       set.colors = colors
       let data = PieChartData(dataSet: set)
       chart.data = data
       chart.noDataText = "No data available"
       
       chart.isUserInteractionEnabled = true

       chart.centerText = "\(generalSum)"
       chart.holeRadiusPercent = 0.5
       chart.transparentCircleColor = UIColor.clear

       self.addSubview(chart)

   }
}
