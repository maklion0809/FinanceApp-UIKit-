//
//  CreateBudgetTableViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 14.01.2021.
//

import UIKit

protocol DelegateViewController {
    func update(text: String)
}

class CreateBudgetTableViewController: UITableViewController, DelegateViewController, DelegateCategory {
    
    var indexBudget: Int?
    var dublicatePeriodBudgetLable: String?
    var dublicateChooseCategoryLabel: String?
    var dublicateCategoryChoose: Category?
    var dublicateNameBudgetTextField: String?
    var dublicateSumEndTextField: String?
    
    @IBOutlet weak var periodBudgetLabel: UILabel!
    
    @IBOutlet weak var chooseCategory: UILabel!
    
    var categoryChoose: Category?
    
    @IBOutlet weak var saveBudgetButton: UIBarButtonItem!
    
    @IBOutlet weak var nameBudgetTextField: UITextField!{
        didSet{
            nameBudgetTextField.attributedPlaceholder = NSAttributedString(string: "Название бюджета", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    
    @IBOutlet weak var sumEndTextField: UITextField!{
        didSet{
            sumEndTextField.attributedPlaceholder = NSAttributedString(string: "0.00", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if indexBudget != nil{
            periodBudgetLabel.text = dublicatePeriodBudgetLable
            chooseCategory.text = dublicateChooseCategoryLabel
            categoryChoose = dublicateCategoryChoose
            nameBudgetTextField.text = dublicateNameBudgetTextField
            sumEndTextField.text = dublicateSumEndTextField
        }else{
            categoryChoose = categoriesExp[0]
            chooseCategory.text = categoriesExp[0].name
            periodBudgetLabel.text = globalPurses[chooseIndex!].period
            saveBudgetButton.isEnabled = false
        }
        
        
        nameBudgetTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        
        sumEndTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        // ввод суммы
        }
    

    
    
    func updateCategory(category: Category) {
        categoryChoose = category
        chooseCategory.text = category.name
    }
    
    func update(text: String) {
        periodBudgetLabel.text = text
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2{
            return 2
        }else{
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 0{
            let sb = storyboard?.instantiateViewController(identifier: "periodTableViewController") as! PeriodTableViewController
            sb.delegatePeriodBudget = self
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: true, completion: nil)
        }
        if indexPath.section == 2 && indexPath.row == 1{
            let sb = storyboard?.instantiateViewController(identifier: "categoryViewController") as! CategoryViewController
            sb.indicator = false
            sb.expInc = ExpInc.expense
            sb.delegateCategoryBudget = self
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }

    
    @IBAction func tappedCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}
extension CreateBudgetTableViewController: UITextFieldDelegate{
    // убираем клавиатуру по нажатию DONE
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChange(){
        if nameBudgetTextField.text?.isEmpty == false && sumEndTextField.text?.isEmpty == false{
            saveBudgetButton.isEnabled = true
        }else{
            saveBudgetButton.isEnabled = false
        }
    }
    
}


