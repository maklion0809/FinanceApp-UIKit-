//
//  TypeTransactionTableViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 20.01.2021.
//

import UIKit

class TypeTransactionTableViewController: UITableViewController {
    
    var delegateTypeTransaction: ReportTableViewController?
    
    var incExp: [ExpInc] = [ExpInc.expense, ExpInc.income]
    
    var typeTransacton: [String] = ["Расходы", "Доходы"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeTransacton.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "typeTransactionCell", for: indexPath)
        cell.textLabel?.text = typeTransacton[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegateTypeTransaction?.updateTypeTransaction(name: typeTransacton[indexPath.row], chooseExpInc: incExp[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
    }
        
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
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
