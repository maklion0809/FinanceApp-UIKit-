//
//  PeriodTableViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 15.01.2021.
//

import UIKit

let namePeriod: [String] = ["Неделя", "Две недели", "Месяц", "Квартал", "Полугодие", "Год", "За все время"]

class PeriodTableViewController: UITableViewController {
    
    var delegatePeriodBudget: CreateBudgetTableViewController?
    
    var delegatePeriodPurse: CreatePurseTableViewController?
    
    var delegatePeriodReport: ReportTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return namePeriod.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "periodTableViewCell", for: indexPath)
        cell.textLabel?.text = namePeriod[indexPath.row]
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegatePeriodPurse?.update(text: namePeriod[indexPath.row])
        delegatePeriodBudget?.update(text: namePeriod[indexPath.row])
        delegatePeriodReport?.update(text: namePeriod[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
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
