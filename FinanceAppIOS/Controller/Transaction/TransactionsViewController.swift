//
//  TransactionsViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 10.12.2020.
//

import UIKit

class TransactionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sortBudgetSegmentedControl: UISegmentedControl!
    @IBAction func tappedSortBudgetSegmentedConrol(_ sender: UISegmentedControl) {
        transactionTableView.reloadData()
    }
    
    var expTransaction: [Transaction] = []
    var incTransaction: [Transaction] = []

    @IBOutlet weak var addTransactionsButton: UIButton!{
        didSet{
            addTransactionsButton.layer.cornerRadius = addTransactionsButton.frame.size.height / 2
            addTransactionsButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var transactionTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expTransaction = []
        incTransaction = []
        if globalPurses[chooseIndex!].transactions.count != 0{
            for i in 0...globalPurses[chooseIndex!].transactions.count - 1{
                if globalPurses[chooseIndex!].transactions[i].expInc == ExpInc.expense{
                    expTransaction.append(globalPurses[chooseIndex!].transactions[i])
                }else{
                    incTransaction.append(globalPurses[chooseIndex!].transactions[i])
                }
            }
        }
        
        globalPurses[chooseIndex!].transactions.sort(by: { $0.date.customDate ?? .distantFuture > $1.date.customDate ?? .distantFuture})

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
    
    @IBAction func tappedAddTransactions(_ sender: UIButton) {
        let sb = self.storyboard?.instantiateViewController(identifier: "createTransactionTableViewController") as! CreateTransactionTableViewController
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if sortBudgetSegmentedControl.selectedSegmentIndex == 1{
            return expTransaction.count
        }else if sortBudgetSegmentedControl.selectedSegmentIndex == 2{
            return incTransaction.count
        }else{
            return globalPurses[chooseIndex!].transactions.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sortBudgetSegmentedControl.selectedSegmentIndex == 1{
            return expTransaction[section].sum + " - " + expTransaction[section].currency
        }else if sortBudgetSegmentedControl.selectedSegmentIndex == 2{
            return incTransaction[section].sum + " - " + incTransaction[section].currency
        }else{
            return globalPurses[chooseIndex!].transactions[section].date + " - " + globalPurses[chooseIndex!].transactions[section].sum + " - " + globalPurses[chooseIndex!].transactions[section].currency
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if sortBudgetSegmentedControl.selectedSegmentIndex == 1 && expTransaction[indexPath.section].expInc == ExpInc.expense{
            let cell = transactionTableView.dequeueReusableCell(withIdentifier: "cellTransactionViewConroller") as! TransactionTableViewCell
            cell.sumLabel?.text = "-" + expTransaction[indexPath.section].sum
            cell.sumLabel?.textColor = .red
            cell.typeCategoryLabel?.text = expTransaction[indexPath.section].category.name
            cell.noteLabel?.text = expTransaction[indexPath.section].note
            cell.colorCategoryView.backgroundColor = expTransaction[indexPath.section].category.color
            return cell
        }else if sortBudgetSegmentedControl.selectedSegmentIndex == 2 && incTransaction[indexPath.section].expInc == ExpInc.income{
            let cell = transactionTableView.dequeueReusableCell(withIdentifier: "cellTransactionViewConroller") as! TransactionTableViewCell
            cell.sumLabel?.text = incTransaction[indexPath.section].sum
            cell.sumLabel?.textColor = .green
            cell.typeCategoryLabel?.text = incTransaction[indexPath.section].category.name
            cell.noteLabel?.text = incTransaction[indexPath.section].note
            cell.colorCategoryView.backgroundColor = incTransaction[indexPath.section].category.color
            return cell
        }else{
            let cell = transactionTableView.dequeueReusableCell(withIdentifier: "cellTransactionViewConroller") as! TransactionTableViewCell
            if globalPurses[chooseIndex!].transactions[indexPath.section].category.expInc == ExpInc.expense{
                cell.sumLabel?.text = "-" + globalPurses[chooseIndex!].transactions[indexPath.section].sum
                cell.sumLabel?.textColor = .red
            }else{
                cell.sumLabel?.text = globalPurses[chooseIndex!].transactions[indexPath.section].sum
                cell.sumLabel?.textColor = .green
            }
            cell.typeCategoryLabel?.text = globalPurses[chooseIndex!].transactions[indexPath.section].category.name
            cell.noteLabel?.text = globalPurses[chooseIndex!].transactions[indexPath.section].note
            cell.colorCategoryView.backgroundColor = globalPurses[chooseIndex!].transactions[indexPath.section].category.color
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let sb = self.storyboard?.instantiateViewController(identifier: "createTransactionTableViewController") as! CreateTransactionTableViewController
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true)
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
            self.transactionTableView.reloadData()
            self.viewDidLoad()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { (contextualAction, view, boolValue) in
                let alert = UIAlertController(title: "Удалить категорию", message: "Вы уверены что хотите удалить транзакцию?", preferredStyle: .actionSheet)
         
            let DeleteAction = UIAlertAction(title: "Удалить", style: .default, handler: { [self]
                    action in
                    globalPurses[chooseIndex!].transactions.remove(at: indexPath.section)
                        transactionTableView.reloadData()
                })
                let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
                    alert.addAction(DeleteAction)
                    alert.addAction(CancelAction)
            
                    self.present(alert, animated: true, completion: nil)
            }

            let edit = UIContextualAction(style: .normal, title: "Изменить") { (contextualAction, view, boolValue) in
                let sb = self.storyboard?.instantiateViewController(identifier: "createTransactionTableViewController") as! CreateTransactionTableViewController
                sb.indexTransaction = indexPath.section
                sb.dublicateSumTextField = globalPurses[chooseIndex!].transactions[indexPath.section].sum
                if globalPurses[chooseIndex!].transactions[indexPath.section].expInc == ExpInc.expense{
                    sb.dublicateExpIncIndex = 0
                }else{
                    sb.dublicateExpIncIndex = 1
                }
                sb.dublicateNoteTextField = globalPurses[chooseIndex!].transactions[indexPath.section].note
                sb.dublicateNameCurrency = globalPurses[chooseIndex!].transactions[indexPath.section].currency
                sb.expInc = globalPurses[chooseIndex!].transactions[indexPath.section].expInc
                sb.dublicateCategoryChoose = globalPurses[chooseIndex!].transactions[indexPath.section].category
                sb.dublicateNameCategoryLabel = globalPurses[chooseIndex!].transactions[indexPath.section].category.name
                sb.dateText = globalPurses[chooseIndex!].transactions[indexPath.section].date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yy"
                let calendarCurrent = Calendar.current.date(byAdding: .day, value: 0, to: Date())
                let calendarYestarday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
                if dateFormatter.string(from: calendarCurrent! as Date) == globalPurses[chooseIndex!].transactions[indexPath.section].date{
                    sb.dublicateDateIndex = 0
                }else if dateFormatter.string(from: calendarYestarday! as Date) == globalPurses[chooseIndex!].transactions[indexPath.section].date{
                    sb.dublicateDateIndex = 1
                }else{
                    sb.dublicateDateIndex = 2
                }
                sb.modalPresentationStyle = .fullScreen
                self.present(sb, animated: true, completion: nil)
            }

            edit.backgroundColor = UIColor.blue
            let swipeActions = UISwipeActionsConfiguration(actions: [delete, edit])
        
            return swipeActions
    }
    
    // MARK: Cancel CreateTableViewController
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        guard let createTransactionTVC = segue.source as? CreateTransactionTableViewController else { return }
        if createTransactionTVC.indexTransaction != 0{
            globalPurses[chooseIndex!].transactions.append(Transaction(sum: createTransactionTVC.sumTextField.text!, expInc: createTransactionTVC.expInc, date: createTransactionTVC.dateText!, note: createTransactionTVC.noteTextField.text ?? "", category: createTransactionTVC.categoryChoose!, currency: (createTransactionTVC.chooseCurrency?.titleLabel?.text)!))
            
        }else{
            globalPurses[chooseIndex!].transactions[createTransactionTVC.indexTransaction!] = Transaction(sum: createTransactionTVC.sumTextField.text!, expInc: createTransactionTVC.expInc, date: createTransactionTVC.dateText!, note: createTransactionTVC.noteTextField.text ?? "", category: createTransactionTVC.categoryChoose!, currency: (createTransactionTVC.chooseCurrency?.titleLabel?.text)!)
        }
        transactionTableView.reloadData()
    }

}
extension Formatter {
    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd.MM.yy"
        return formatter
    }()
}
extension String {
    var customDate: Date? { Formatter.date.date(from: self) }
}

