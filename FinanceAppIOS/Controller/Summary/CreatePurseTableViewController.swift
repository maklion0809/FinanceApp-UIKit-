//
//  CreatePurseTableViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 14.01.2021.
//

import UIKit

protocol DelegateCurrencyViewController {
    func updateCurrency(text: String, initial: String)
}

class CreatePurseTableViewController: UITableViewController, DelegateViewController, DelegateCurrencyViewController {
    
    var index: Int?
    
    var indicator: Bool = true
    
    @IBOutlet weak var choosePeriodLabel: UILabel!
    var dublicateChoosePeriodLabel: String?
    
    @IBOutlet weak var chooseCurrencyLabel: UILabel!
    var dublicateChooseCurrencyLabel: String?
    var addChooseCurrency: String?
    var dublicateAddChooseCurrency: String?
    
    @IBOutlet weak var savePurseButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelPurseButton: UIBarButtonItem!
    
    @IBOutlet weak var namePurseTextField: UITextField!{
        didSet{
            namePurseTextField.attributedPlaceholder = NSAttributedString(string: "Название текстом или эмодзи", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    var dublicateNamePurseTextField: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if index != nil{
            choosePeriodLabel.text = dublicateChoosePeriodLabel
            addChooseCurrency = dublicateAddChooseCurrency
            chooseCurrencyLabel.text = dublicateChooseCurrencyLabel
            namePurseTextField.text = dublicateNamePurseTextField
        }else{
            chooseCurrencyLabel.text = infCurrency[16][1]
            addChooseCurrency = infCurrency[16][0]
            choosePeriodLabel.text = namePeriod[2]
            
            savePurseButton.isEnabled = false
        }
        namePurseTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        if indicator{
            cancelPurseButton.isEnabled = indicator
        }else{
            cancelPurseButton.isEnabled = indicator
            cancelPurseButton.tintColor = .clear
        }
        

    }
    
    func update(text: String) {
        choosePeriodLabel.text = text
    }
    
    func updateCurrency(text: String, initial: String) {
        chooseCurrencyLabel.text = text
        addChooseCurrency = initial
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    /*override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.red
        return headerView
    }*/
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
 
    @IBAction func tappedCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var purseNavigationBar: UINavigationBar!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if numberOfSections(in: tableView) == 2 && indexPath.row == 0{
            let sb = storyboard?.instantiateViewController(identifier: "periodTableViewController") as! PeriodTableViewController
            sb.delegatePeriodPurse = self
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: true, completion: nil)
        } else if numberOfSections(in: tableView) == 2 && indexPath.row == 1{
            let sb = storyboard?.instantiateViewController(identifier: "currencyTableViewController") as! CurrencyTableViewController
            sb.delegateCurrencyPurse = self
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
extension CreatePurseTableViewController: UITextFieldDelegate{
    // убираем клавиатуру по нажатию DONE
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChange(){
        if namePurseTextField.text?.isEmpty == false{
            savePurseButton.isEnabled = true
        }else{
            savePurseButton.isEnabled = false
        }
    }
    
}
