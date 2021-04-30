//
//  ViewReportTableViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 19.01.2021.
//

import UIKit

class ViewReportTableViewController: UITableViewController {

    var period: String?
    
    var typeTransaction: ExpInc?
    
    var transactionPeriod: [Transaction] = []
    
    var oridginTransaction: [Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if globalPurses[chooseIndex!].transactions.count != 0{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy"
            switch period {
            case namePeriod[0]:
                if let calendar = Calendar.current.date(byAdding: .weekdayOrdinal, value: -1, to: Date()){
                    if let currentCalendar = Calendar.current.date(byAdding: .day, value: 0, to: Date()){
                        for i in 0...globalPurses[chooseIndex!].transactions.count - 1{
                            let string = globalPurses[chooseIndex!].transactions[i].date
                            if let chooseDate = dateFormatter.date(from: string){
                                if calendar <= chooseDate && currentCalendar >= chooseDate && globalPurses[chooseIndex!].transactions[i].expInc == typeTransaction{
                                    transactionPeriod.append(globalPurses[chooseIndex!].transactions[i])
                                }
                            }
                        }
                    }
                }
            case namePeriod[1]:
                if let calendar = Calendar.current.date(byAdding: .weekdayOrdinal, value: -2, to: Date()){
                    if let currentCalendar = Calendar.current.date(byAdding: .day, value: 0, to: Date()){
                        for i in 0...globalPurses[chooseIndex!].transactions.count - 1{
                            let string = globalPurses[chooseIndex!].transactions[i].date
                            if let chooseDate = dateFormatter.date(from: string){
                                if calendar <= chooseDate && currentCalendar >= chooseDate && globalPurses[chooseIndex!].transactions[i].expInc == typeTransaction{
                                    transactionPeriod.append(globalPurses[chooseIndex!].transactions[i])
                                }
                            }
                        }
                    }
                }
            case namePeriod[2]:
                if let calendar = Calendar.current.date(byAdding: .month, value: -1, to: Date()){
                    if let currentCalendar = Calendar.current.date(byAdding: .day, value: 0, to: Date()){
                        for i in 0...globalPurses[chooseIndex!].transactions.count - 1{
                            let string = globalPurses[chooseIndex!].transactions[i].date
                            if let chooseDate = dateFormatter.date(from: string){
                                if calendar <= chooseDate && currentCalendar >= chooseDate && globalPurses[chooseIndex!].transactions[i].expInc == typeTransaction{
                                    transactionPeriod.append(globalPurses[chooseIndex!].transactions[i])
                                }
                            }
                        }
                    }
                }
            case namePeriod[3]:
                let choosePeriod = Date().startOfQuarter
                if let currentCalendar = Calendar.current.date(byAdding: .day, value: 0, to: Date()){
                    for i in 0...globalPurses[chooseIndex!].transactions.count - 1{
                        let string = globalPurses[chooseIndex!].transactions[i].date
                        if let chooseDate = dateFormatter.date(from: string){
                            if choosePeriod <= chooseDate && currentCalendar >= chooseDate && globalPurses[chooseIndex!].transactions[i].expInc == typeTransaction{
                                transactionPeriod.append(globalPurses[chooseIndex!].transactions[i])
                            }
                        }
                    }
                }
            case namePeriod[4]:
                if let calendar = Calendar.current.date(byAdding: .month, value: -6, to: Date()){
                    if let currentCalendar = Calendar.current.date(byAdding: .day, value: 0, to: Date()){
                        for i in 0...globalPurses[chooseIndex!].transactions.count - 1{
                            let string = globalPurses[chooseIndex!].transactions[i].date
                            if let chooseDate = dateFormatter.date(from: string){
                                if calendar <= chooseDate && currentCalendar >= chooseDate && globalPurses[chooseIndex!].transactions[i].expInc == typeTransaction{
                                    transactionPeriod.append(globalPurses[chooseIndex!].transactions[i])
                                }
                            }
                        }
                    }
                }
            case namePeriod[5]:
                if let calendar = Calendar.current.date(byAdding: .year, value: -1, to: Date()){
                    if let currentCalendar = Calendar.current.date(byAdding: .day, value: 0, to: Date()){
                        for i in 0...globalPurses[chooseIndex!].transactions.count - 1{
                            let string = globalPurses[chooseIndex!].transactions[i].date
                            if let chooseDate = dateFormatter.date(from: string){
                                if calendar <= chooseDate && currentCalendar >= chooseDate && globalPurses[chooseIndex!].transactions[i].expInc == typeTransaction{
                                    transactionPeriod.append(globalPurses[chooseIndex!].transactions[i])
                                }
                            }
                        }
                    }
                }
            default:
                for i in 0...globalPurses[chooseIndex!].transactions.count - 1 {
                    if globalPurses[chooseIndex!].transactions[i].expInc == typeTransaction{
                        transactionPeriod = globalPurses[chooseIndex!].transactions
                    }
                }
            }
            if transactionPeriod.count > 1{
                for i in 0...transactionPeriod.count - 1{
                    if !(oridginTransaction.contains(where: { $0.category.name == transactionPeriod[i].category.name})){
                        var sum: Double = 0.00
                        for j in i...transactionPeriod.count - 1{
                            if transactionPeriod[i].category.name == transactionPeriod[j].category.name {
                                sum += Double(transactionPeriod[j].sum) ?? 0.00
                            }
                        }
                        oridginTransaction.append(Transaction(sum: String(sum), expInc: typeTransaction!, date: "", note: "", category: transactionPeriod[i].category, currency: globalPurses[chooseIndex!].currency[1]))
                    }
                }
            }else if transactionPeriod.count == 1{
                oridginTransaction.append(transactionPeriod[0])
            }else{
                messageAlert(title: "Отчет", message: "Отчет пуст")
            }
        }else{
            messageAlert(title: "Отчет", message: "Отчет пуст")
        }
    }
    
    func messageAlert(title: String, message: String){
        let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            action in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if oridginTransaction.count == 0{
            return 0
        }else{
            return oridginTransaction.count + 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 400
        }else{
            return 100
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "diagramTableViewCell") as! DiagramTableViewCell
            cell.infTransaction = oridginTransaction
            cell.updateChartData()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier:"transactionDiagramTableViewCell") as! TransactionDiagramTableViewCell
            cell.nameCategoryTransaction.text = oridginTransaction[indexPath.row - 1].category.name
            cell.generalSumTransaction.text = oridginTransaction[indexPath.row - 1].sum
            cell.colorCategoryTransaction.backgroundColor = oridginTransaction[indexPath.row - 1].category.color
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 4

        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }

    @IBAction func tappedCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
extension Date {
    public var startOfQuarter: Date {
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
        var components = Calendar.current.dateComponents([.month, .day, .year], from: startOfMonth)
        let newMonth: Int
        switch components.month! {
        case 1,2,3: newMonth = 1
        case 4,5,6: newMonth = 4
        case 7,8,9: newMonth = 7
        case 10,11,12: newMonth = 10
        default: newMonth = 1
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        components.month = newMonth
        let calendar = Calendar.current.date(from: components)!
        return calendar
    }
}

