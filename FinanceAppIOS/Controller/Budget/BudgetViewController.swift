//
//  BudgetViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 10.12.2020.
//

import UIKit

class BudgetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addBudgetButton: UIButton!{
        didSet{
            addBudgetButton.layer.cornerRadius = addBudgetButton.frame.size.height / 2
            addBudgetButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var budgetTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if globalPurses[chooseIndex!].budgets.count != 0 && globalPurses[chooseIndex!].transactions.count != 0{
            for i in 0...globalPurses[chooseIndex!].budgets.count - 1{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yy"
                var sum: Double = 0.00
                switch globalPurses[chooseIndex!].budgets[i].period {
                case namePeriod[0]:
                    if let calendar = Calendar.current.date(byAdding: .weekdayOrdinal, value: -1, to: Date()){
                        if let currentCalendar = Calendar.current.date(byAdding: .day, value: 0, to: Date()){
                            for j in 0...globalPurses[chooseIndex!].transactions.count - 1{
                                let string = globalPurses[chooseIndex!].transactions[i].date
                                if let chooseDate = dateFormatter.date(from: string){
                                    if calendar <= chooseDate && currentCalendar >= chooseDate && globalPurses[chooseIndex!].budgets[i].category.name == globalPurses[chooseIndex!].transactions[j].category.name{
                                        sum += Double(globalPurses[chooseIndex!].transactions[j].sum) ?? 0.00
                                    }
                                }
                            }
                        }
                    }
                case namePeriod[1]:
                    if let calendar = Calendar.current.date(byAdding: .weekdayOrdinal, value: -2, to: Date()){
                        if let currentCalendar = Calendar.current.date(byAdding: .day, value: 0, to: Date()){
                            for j in 0...globalPurses[chooseIndex!].transactions.count - 1{
                                let string = globalPurses[chooseIndex!].transactions[i].date
                                if let chooseDate = dateFormatter.date(from: string){
                                    if calendar <= chooseDate && currentCalendar >= chooseDate && globalPurses[chooseIndex!].budgets[i].category.name == globalPurses[chooseIndex!].transactions[j].category.name{
                                        sum += Double(globalPurses[chooseIndex!].transactions[j].sum) ?? 0.00
                                    }
                                }
                            }
                        }
                    }
                case namePeriod[2]:
                    if let calendar = Calendar.current.date(byAdding: .month, value: -1, to: Date()){
                        if let currentCalendar = Calendar.current.date(byAdding: .day, value: 0, to: Date()){
                            for j in 0...globalPurses[chooseIndex!].transactions.count - 1{
                                let string = globalPurses[chooseIndex!].transactions[i].date
                                if let chooseDate = dateFormatter.date(from: string){
                                    if calendar <= chooseDate && currentCalendar >= chooseDate && globalPurses[chooseIndex!].budgets[i].category.name == globalPurses[chooseIndex!].transactions[j].category.name{
                                        sum += Double(globalPurses[chooseIndex!].transactions[j].sum) ?? 0.00
                                    }
                                }
                            }
                        }
                    }
                case namePeriod[3]:
                    let choosePeriod = Date().startOfQuarter
                    if let currentCalendar = Calendar.current.date(byAdding: .day, value: 0, to: Date()){
                        for j in 0...globalPurses[chooseIndex!].transactions.count - 1{
                            let string = globalPurses[chooseIndex!].transactions[i].date
                            if let chooseDate = dateFormatter.date(from: string){
                                if choosePeriod <= chooseDate && currentCalendar >= chooseDate && globalPurses[chooseIndex!].budgets[i].category.name == globalPurses[chooseIndex!].transactions[j].category.name{
                                    sum += Double(globalPurses[chooseIndex!].transactions[j].sum) ?? 0.00
                                }
                            }
                        }
                    }
                case namePeriod[4]:
                    if let calendar = Calendar.current.date(byAdding: .month, value: -6, to: Date()){
                        if let currentCalendar = Calendar.current.date(byAdding: .day, value: 0, to: Date()){
                            for j in 0...globalPurses[chooseIndex!].transactions.count - 1{
                                let string = globalPurses[chooseIndex!].transactions[i].date
                                if let chooseDate = dateFormatter.date(from: string){
                                    if calendar <= chooseDate && currentCalendar >= chooseDate && globalPurses[chooseIndex!].budgets[i].category.name == globalPurses[chooseIndex!].transactions[j].category.name{
                                        sum += Double(globalPurses[chooseIndex!].transactions[j].sum) ?? 0.00
                                    }
                                }
                            }
                        }
                    }
                case namePeriod[5]:
                    if let calendar = Calendar.current.date(byAdding: .year, value: -1, to: Date()){
                        if let currentCalendar = Calendar.current.date(byAdding: .day, value: 0, to: Date()){
                            for j in 0...globalPurses[chooseIndex!].transactions.count - 1{
                                let string = globalPurses[chooseIndex!].transactions[i].date
                                if let chooseDate = dateFormatter.date(from: string){
                                    if calendar <= chooseDate && currentCalendar >= chooseDate && globalPurses[chooseIndex!].budgets[i].category.name == globalPurses[chooseIndex!].transactions[j].category.name{
                                        sum += Double(globalPurses[chooseIndex!].transactions[j].sum) ?? 0.00
                                    }
                                }
                            }
                        }
                    }
                default:
                    for j in 0...globalPurses[chooseIndex!].transactions.count - 1 {
                        if globalPurses[chooseIndex!].budgets[i].category.name == globalPurses[chooseIndex!].transactions[j].category.name{
                            sum += Double(globalPurses[chooseIndex!].transactions[j].sum) ?? 0.00
                        }
                    }
                }
                globalPurses[chooseIndex!].budgets[i].sumBegin = String(sum)
            }
        }
        
       // globalPurses[chooseIndex!].budgets

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }

    @objc func swiped(_ gesture: UISwipeGestureRecognizer) {
            if gesture.direction == .left {
                if (self.tabBarController?.selectedIndex)! < 4 {
                    self.tabBarController?.selectedIndex += 1
                }
            } else if gesture.direction == .right {
                if (self.tabBarController?.selectedIndex)! > 0 {
                    self.tabBarController?.selectedIndex -= 1
                }
            }
        }
    
    @IBAction func tappedAddBudget(_ sender: UIButton) {
        let sb = self.storyboard?.instantiateViewController(identifier: "createBudgetTableViewController") as! CreateBudgetTableViewController
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return globalPurses[chooseIndex!].budgets.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return globalPurses[chooseIndex!].budgets[section].category.name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = budgetTableView.dequeueReusableCell(withIdentifier: "budgetTableViewCell") as! BudgetTableViewCell
        cell.nameBudgetLabel.text = globalPurses[chooseIndex!].budgets[indexPath.section].name
        cell.endSumLabel.text = globalPurses[chooseIndex!].budgets[indexPath.section].sumEnd
        cell.periodLabel.text = globalPurses[chooseIndex!].budgets[indexPath.section].period
        cell.currentSumLabel.text = globalPurses[chooseIndex!].budgets[indexPath.section].sumBegin
        let beginCost = Float(globalPurses[chooseIndex!].budgets[indexPath.section].sumBegin) ?? 0.00
        let endCost = Float(globalPurses[chooseIndex!].budgets[indexPath.section].sumEnd) ?? 0.00
        if beginCost/endCost > 1{
            cell.progeressView.progressTintColor = .red
        }else{
            cell.progeressView.progressTintColor = #colorLiteral(red: 0.9303327203, green: 0.7367609739, blue: 0.3937830329, alpha: 1)
        }
        cell.progeressView.progress = beginCost/endCost
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { (contextualAction, view, boolValue) in
                let alert = UIAlertController(title: "Удалить категорию", message: "Вы уверены что хотите удалить транзакцию?", preferredStyle: .actionSheet)
         
            let DeleteAction = UIAlertAction(title: "Удалить", style: .default, handler: { [self]
                    action in
                    globalPurses[chooseIndex!].budgets.remove(at: indexPath.section)
                        budgetTableView.reloadData()
                })
                let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
                    alert.addAction(DeleteAction)
                    alert.addAction(CancelAction)
            
                    self.present(alert, animated: true, completion: nil)
            }

            let edit = UIContextualAction(style: .normal, title: "Изменить") { (contextualAction, view, boolValue) in
                let sb = self.storyboard?.instantiateViewController(identifier: "createBudgetTableViewController") as! CreateBudgetTableViewController
                sb.indexBudget = indexPath.section
                sb.dublicateCategoryChoose = globalPurses[chooseIndex!].budgets[indexPath.section].category
                sb.dublicateChooseCategoryLabel = globalPurses[chooseIndex!].budgets[indexPath.section].category.name
                sb.dublicateNameBudgetTextField = globalPurses[chooseIndex!].budgets[indexPath.section].name
                sb.dublicateSumEndTextField = globalPurses[chooseIndex!].budgets[indexPath.section].sumEnd
                sb.dublicatePeriodBudgetLable = globalPurses[chooseIndex!].budgets[indexPath.section].period
                sb.modalPresentationStyle = .fullScreen
                self.present(sb, animated: true, completion: nil)
            }

            edit.backgroundColor = UIColor.blue
            let swipeActions = UISwipeActionsConfiguration(actions: [delete, edit])
        
            return swipeActions
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 4

        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.viewDidLoad()
            self.budgetTableView.reloadData()
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        guard let createBudgetTVC = segue.source as? CreateBudgetTableViewController else { return }
        if createBudgetTVC.indexBudget == nil{
            globalPurses[chooseIndex!].budgets.append(Budget(sumBegin: "0.00", sumEnd: createBudgetTVC.sumEndTextField.text!, name: createBudgetTVC.nameBudgetTextField.text!, period: createBudgetTVC.periodBudgetLabel.text!, category: createBudgetTVC.categoryChoose!))
            
        }else{
            globalPurses[chooseIndex!].budgets[createBudgetTVC.indexBudget!] = Budget(sumBegin: "0.00", sumEnd: createBudgetTVC.sumEndTextField.text!, name: createBudgetTVC.nameBudgetTextField.text!, period: createBudgetTVC.periodBudgetLabel.text!, category: createBudgetTVC.categoryChoose!)
        }
        budgetTableView.reloadData()
        viewDidLoad()
    }

}
