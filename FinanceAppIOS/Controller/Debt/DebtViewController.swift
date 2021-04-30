//
//  DebtViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 10.12.2020.
//

import UIKit

class DebtViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var segmentedControlDebt: UISegmentedControl!
    
    @IBAction func tappedSegmentedControlDebt(_ sender: UISegmentedControl) {
        debtTableView.reloadData()
        viewDidLoad()
    }
    
    var whoDebts: [Dept] = []
    var whomDebts: [Dept] = []
    
    @IBOutlet weak var addDeptButton: UIButton!{
        didSet{
            addDeptButton.layer.cornerRadius = addDeptButton.frame.size.height / 2
            addDeptButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var debtTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whoDebts = []
        whomDebts = []
        if globalPurses[chooseIndex!].depts.count != 0{
            for i in 0...globalPurses[chooseIndex!].depts.count - 1{
                if globalPurses[chooseIndex!].depts[i].type == WhoAndWhom.whom{
                    whomDebts.append(globalPurses[chooseIndex!].depts[i])
                }else{
                    whoDebts.append(globalPurses[chooseIndex!].depts[i])
                }
            }
        }

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

    
    @IBAction func tappedAddDept(_ sender: UIButton) {
        let sb = self.storyboard?.instantiateViewController(identifier: "createDebtTableViewController") as! CreateDebtTableViewController
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if segmentedControlDebt.selectedSegmentIndex == 0{
            return whomDebts.count
        }else{
            return whoDebts.count
        }

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if segmentedControlDebt.selectedSegmentIndex == 0{
            return whomDebts[section].sum + "  " + whomDebts[section].currency
        }else{
            return whoDebts[section].sum + "  " + whoDebts[section].currency
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControlDebt.selectedSegmentIndex == 0 && whomDebts[indexPath.section].type == WhoAndWhom.whom{
            let cell = debtTableView.dequeueReusableCell(withIdentifier: "debtTableViewCell") as! DebtTableViewCell
            cell.dateReturnLabel.text = whomDebts[indexPath.section].dateEnd
            cell.whoAndWhomLabel.text = whomDebts[indexPath.section].name
            cell.sumDebtLabel.text = whomDebts[indexPath.section].sum + " " + whomDebts[indexPath.section].currency
            cell.noteLabel.text = whomDebts[indexPath.section].note
            return cell
        }else{
            let cell = debtTableView.dequeueReusableCell(withIdentifier: "debtTableViewCell") as! DebtTableViewCell
            cell.dateReturnLabel.text = whoDebts[indexPath.section].dateEnd
            cell.whoAndWhomLabel.text = whoDebts[indexPath.section].name
            cell.sumDebtLabel.text = whoDebts[indexPath.section].sum + " " + whoDebts[indexPath.section].currency
            cell.noteLabel.text = whoDebts[indexPath.section].note
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { (contextualAction, view, boolValue) in
                let alert = UIAlertController(title: "Удалить категорию", message: "Вы уверены что хотите удалить транзакцию?", preferredStyle: .actionSheet)
         
            let DeleteAction = UIAlertAction(title: "Удалить", style: .default, handler: { [self]
                    action in
                    globalPurses[chooseIndex!].depts.remove(at: indexPath.section)
                    debtTableView.reloadData()
                })
                let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
                    alert.addAction(DeleteAction)
                    alert.addAction(CancelAction)
            
                    self.present(alert, animated: true, completion: nil)
            }

            let edit = UIContextualAction(style: .normal, title: "Изменить") { (contextualAction, view, boolValue) in
                let sb = self.storyboard?.instantiateViewController(identifier: "createDebtTableViewController") as! CreateDebtTableViewController
                sb.indexDebt = indexPath.section
                if globalPurses[chooseIndex!].depts[indexPath.section].type == WhoAndWhom.whom{
                    sb.dublicateWhoAndWhomIndex = 0
                    sb.dublicateWhoAndWhom = WhoAndWhom.who
                }else{
                    sb.dublicateWhoAndWhomIndex = 1
                    sb.dublicateWhoAndWhom = WhoAndWhom.whom
                }
                sb.dublicateSumDebtTextField = globalPurses[chooseIndex!].depts[indexPath.section].sum
                sb.dublicateWhoAndWhomTextField = globalPurses[chooseIndex!].depts[indexPath.section].name
                sb.dublicateChooseCurrency = globalPurses[chooseIndex!].depts[indexPath.section].currency
                sb.dublicateTakeDebt = globalPurses[chooseIndex!].depts[indexPath.section].dateStart
                sb.dublicateReturnDebt = globalPurses[chooseIndex!].depts[indexPath.section].dateEnd
                sb.dublicateNoteTextField = globalPurses[chooseIndex!].depts[indexPath.section].note
                sb.modalPresentationStyle = .fullScreen
                self.present(sb, animated: true, completion: nil)
            }

            edit.backgroundColor = UIColor.blue
            let swipeActions = UISwipeActionsConfiguration(actions: [delete, edit])
        
            return swipeActions
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
            self.debtTableView.reloadData()
            self.viewDidLoad()
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        guard let createDebtTVC = segue.source as? CreateDebtTableViewController else { return }
        if createDebtTVC.indexDebt == nil{
            globalPurses[chooseIndex!].depts.append(Dept(sum: createDebtTVC.sumDebtTextField.text!, name: createDebtTVC.whoOrWhomTextField.text!, dateEnd: (createDebtTVC.dateReturnButton.titleLabel?.text)!, dateStart: (createDebtTVC.dateTakeButton.titleLabel?.text)!, note: createDebtTVC.noteTextField.text ?? "", type: createDebtTVC.whoAndWhom, currency: (createDebtTVC.changeCurrency?.titleLabel?.text)!))
        }else{
            globalPurses[chooseIndex!].depts[createDebtTVC.indexDebt!] = Dept(sum: createDebtTVC.sumDebtTextField.text!, name: createDebtTVC.whoOrWhomTextField.text!, dateEnd: (createDebtTVC.dateReturnButton.titleLabel?.text)!, dateStart: (createDebtTVC.dateTakeButton.titleLabel?.text)!, note: createDebtTVC.noteTextField.text ?? "", type: createDebtTVC.whoAndWhom, currency: (createDebtTVC.changeCurrency?.titleLabel?.text)!)
        }
        debtTableView.reloadData()
        viewDidLoad()
    }

}
