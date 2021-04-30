//
//  ReportTableViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 18.01.2021.
//

import UIKit

protocol DelegateTypeTransaction{
    func updateTypeTransaction(name: String, chooseExpInc: ExpInc)
}

class ReportTableViewController: UITableViewController, DelegateViewController, DelegateTypeTransaction, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var periodReportLabel: UILabel!
    
    var expInc: ExpInc = ExpInc.expense
    
    @IBOutlet weak var typeTransactionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        periodReportLabel.text = globalPurses[chooseIndex!].period
        
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 2
        } else{
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0{
            let sb = storyboard?.instantiateViewController(identifier: "periodTableViewController") as! PeriodTableViewController
            sb.delegatePeriodReport = self
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: true, completion: nil)
        
        }
        if indexPath.section == 0 && indexPath.row == 1{
            let sb = storyboard?.instantiateViewController(identifier: "typeTransactionTableViewController") as! TypeTransactionTableViewController
            sb.delegateTypeTransaction = self
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: true, completion: nil)
        }
        if indexPath.section == 1 && indexPath.row == 0{
            let sb = storyboard?.instantiateViewController(identifier: "viewReportTableViewController") as! ViewReportTableViewController
            sb.modalPresentationStyle = .fullScreen
            sb.typeTransaction = expInc
            sb.period = periodReportLabel.text
            self.present(sb, animated: true, completion: nil)
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43.5
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    func update(text: String) {
        periodReportLabel.text = text
    }
    
    func updateTypeTransaction(name: String, chooseExpInc: ExpInc) {
        typeTransactionLabel.text = name
        expInc = chooseExpInc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
