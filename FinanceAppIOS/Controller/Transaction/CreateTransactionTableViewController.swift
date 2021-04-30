//
//  CreateTransactionTableViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 14.01.2021.
//

import UIKit
import YYCalendar

protocol DelegateCategory {
    func updateCategory(category: Category)
}

var weekArray: [String] = ["Пон","Втор","Сред","Чет","Пят","Суб","Вос"]

class CreateTransactionTableViewController: UITableViewController, UIPickerViewDelegate, DelegateCategory, DelegateCurrencyViewController{
    
    var indexTransaction: Int?
    var dublicateSumTextField: String?
    var dublicateExpIncIndex: Int?
    var dublicateNameCategoryLabel: String?
    var dublicateCategoryChoose: Category?
    var dublicateDateIndex: Int?
    var dublicateNoteTextField: String?
    var dublicateNameCurrency: String?
    
    var dateText: String?
        
    @IBOutlet weak var nameCategoryChoose: UILabel!
    
    var categoryChoose: Category?
    
    var expInc: ExpInc = ExpInc.expense
    
    @IBOutlet weak var expIncSegmentedControl: UISegmentedControl!
    
    @IBAction func expIncSegmentedControl(_ sender: UISegmentedControl) {
        switch expIncSegmentedControl.selectedSegmentIndex {
        case 0:
            categoryChoose = categoriesExp[0]
            nameCategoryChoose.text = categoriesExp[0].name
            expInc = ExpInc.expense
        default:
            categoryChoose = categoriesInc[0]
            nameCategoryChoose.text = categoriesInc[0].name
            expInc = ExpInc.income
        }
    }
    
    @IBOutlet weak var saveTransactionButton: UIBarButtonItem!
    
    @IBOutlet weak var nameCategoryLabel: UILabel!
    
    @IBOutlet weak var sumTextField: UITextField!{
        didSet{
            sumTextField.attributedPlaceholder = NSAttributedString(string: "0.00", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    
    
    

    
    @IBOutlet weak var dataSegmentedControl: UISegmentedControl!
    @IBAction func tappedDataSegmentedControl(_ sender: UISegmentedControl) {
        switch dataSegmentedControl.selectedSegmentIndex {
        case 0:
            dateText = getDate(day: 0)
        case 1:
            dateText = getDate(day: -1)
        default:
            let calendar = YYCalendar(normalCalendarLangType: .custom(weekArray), date: getDate(day: 0)!, format: "dd.MM.yy") { date in
                self.dataSegmentedControl.setTitle(date, forSegmentAt: 2)
                self.dateText = date
            }
            calendar.show()
        }
    }
    
    @IBOutlet weak var chooseCurrency: UIButton!

    @IBOutlet weak var noteTextField: UITextField!{
        didSet{
            noteTextField.attributedPlaceholder = NSAttributedString(string: "Заметка", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if indexTransaction != nil{
            sumTextField.text = dublicateSumTextField
            expIncSegmentedControl.selectedSegmentIndex = dublicateExpIncIndex!
            nameCategoryChoose.text = dublicateNameCategoryLabel
            dataSegmentedControl.selectedSegmentIndex = dublicateDateIndex!
            if dublicateDateIndex! == 2{
                dataSegmentedControl.setTitle(dateText, forSegmentAt: 2)
            }
            noteTextField.text = dublicateNoteTextField
            chooseCurrency.setTitle(dublicateNameCurrency, for: .normal)
            categoryChoose = dublicateCategoryChoose
        }else{
            categoryChoose = categoriesExp[0]
            nameCategoryChoose.text = categoriesExp[0].name
        
            chooseCurrency.setTitle(globalPurses[chooseIndex!].currency[1], for: .normal)
            nameCategoryChoose.text = categoryChoose?.name
            dateText = getDate(day: 0)
            saveTransactionButton.isEnabled = false
        }
        
        
        sumTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    }
    
    func updateCategory(category: Category) {
        categoryChoose = category
        nameCategoryChoose.text = category.name
    }
    
    func updateCurrency(text: String, initial: String) {
        chooseCurrency.setTitle(initial, for: .normal)
    }

    @IBAction func tappedCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func tappedChooseCurrency(_ sender: UIButton) {
        let sb = storyboard?.instantiateViewController(identifier: "currencyTableViewController") as! CurrencyTableViewController
        sb.delegateCurrencyTransaction = self
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true, completion: nil)
    }
    
    
    func getDate(day: Int) -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        guard let calendar = Calendar.current.date(byAdding: .day, value: day, to: Date()) else { return nil}
        return dateFormatter.string(from: calendar as Date)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            return 80
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        let verticalPadding: CGFloat = 30
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(numberOfSections(in: tableView))
        if indexPath.section == 2 && indexPath.row == 0{
            let sb = storyboard?.instantiateViewController(identifier: "categoryViewController") as! CategoryViewController
            sb.delegateChooseCategory = self
            sb.expInc = expInc
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int){
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
}

// MARK: Text Field delegate
extension CreateTransactionTableViewController: UITextFieldDelegate{
    
    // убираем клавиатуру по нажатию DONE
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChange(){
        if sumTextField.text?.isEmpty == false{
            saveTransactionButton.isEnabled = true
        }else{
            saveTransactionButton.isEnabled = false
        }
    }
    
}
