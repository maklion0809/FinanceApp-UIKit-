//
//  CreateDebtTableViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 14.01.2021.
//

import UIKit
import YYCalendar

class CreateDebtTableViewController: UITableViewController,DelegateCurrencyViewController {
    
    var indexDebt: Int?
    var dublicateWhoAndWhomIndex: Int?
    var dublicateWhoAndWhom: WhoAndWhom?
    var dublicateSumDebtTextField: String?
    var dublicateChooseCurrency: String?
    var dublicateWhoAndWhomTextField: String?
    var dublicateReturnDebt: String?
    var dublicateTakeDebt: String?
    var dublicateNoteTextField: String?
    
    @IBOutlet weak var changeCurrency: UIButton!
 
    @IBAction func tappedChangeCurrency(_ sender: UIButton) {
        let sb = self.storyboard?.instantiateViewController(identifier: "currencyTableViewController") as! CurrencyTableViewController
        sb.delegateCurrencyDebt = self
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true)
    }
    
    @IBOutlet weak var saveDebtButton: UIBarButtonItem!
    
    @IBOutlet weak var debtSegmentedControl: UISegmentedControl!
    
    var whoAndWhom: WhoAndWhom = WhoAndWhom.whom
    
    @IBAction func tappedDebtSegmentedControl(_ sender: UISegmentedControl) {
        switch debtSegmentedControl.selectedSegmentIndex {
        case 0:
            whoAndWhom = WhoAndWhom.whom
            whoOrWhomTextField.placeholder = "Кому я должен"
        default:
            whoAndWhom = WhoAndWhom.who
            whoOrWhomTextField.placeholder = "Кто мне должен"
        }
    }
    
    
    @IBOutlet weak var sumDebtTextField: UITextField!{
        didSet{
            sumDebtTextField.attributedPlaceholder = NSAttributedString(string: "0.00", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    @IBOutlet weak var noteTextField: UITextField!{
        didSet{
            noteTextField.attributedPlaceholder = NSAttributedString(string: "Заметка", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    
    @IBOutlet weak var dateTakeButton: UIButton!
    
    @IBOutlet weak var dateReturnButton: UIButton!
    @IBOutlet weak var whoOrWhomTextField: UITextField!{
        didSet{
            whoOrWhomTextField.attributedPlaceholder = NSAttributedString(string: "Кому я должен", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if indexDebt != nil{
            debtSegmentedControl.selectedSegmentIndex = dublicateWhoAndWhomIndex!
            sumDebtTextField.text = dublicateSumDebtTextField
            changeCurrency.setTitle(dublicateChooseCurrency, for: .normal)
            whoAndWhom = dublicateWhoAndWhom!
            whoOrWhomTextField.text = dublicateWhoAndWhomTextField
            dateTakeButton.setTitle(dublicateTakeDebt, for: .normal)
            dateReturnButton.setTitle(dublicateReturnDebt, for: .normal)
            noteTextField.text = dublicateNoteTextField
        }else{
            changeCurrency.setTitle(globalPurses[chooseIndex!].currency[1], for: .normal)
            dateTakeButton.setTitle(getDate(day: 0), for: .normal)
            dateReturnButton.setTitle("Дата возврата", for: .normal)
            saveDebtButton.isEnabled = false
        }
        
        whoOrWhomTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
        sumDebtTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    }
    
    func updateCurrency(text: String, initial: String) {
        changeCurrency.setTitle(initial, for: .normal)
    }
    
    @IBAction func tappedDateTake(_ sender: UIButton) {
        let calendar = YYCalendar(normalCalendarLangType: .custom(weekArray), date: getDate(day: 0)!, format: "dd.MM.yy") { date in
            self.dateTakeButton.setTitle(date, for: .normal)
        }
        calendar.show()
    }
    
    @IBAction func tappedDateReturn(_ sender: UIButton) {
        let calendar = YYCalendar(normalCalendarLangType: .custom(weekArray), date: getDate(day: 0)!, format: "dd.MM.yy") { date in
            self.dateReturnButton.setTitle(date, for: .normal)
        }
        calendar.show()
    }
    
    func getDate(day: Int) -> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        guard let calendar = Calendar.current.date(byAdding: .day, value: 0, to: Date()) else { return nil}
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
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    @IBAction func tappedCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension CreateDebtTableViewController: UITextFieldDelegate{
    
    // убираем клавиатуру по нажатию DONE
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChange(){
        if sumDebtTextField.text?.isEmpty == false && whoOrWhomTextField.text?.isEmpty == false{
                saveDebtButton.isEnabled = true
        }else{
                saveDebtButton.isEnabled = false
        }

    }
}
