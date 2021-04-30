//
//  CategoryViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 14.01.2021.
//

import UIKit

var categoriesInc: [Category] = [Category(name: "Без категории", color: UIColor.white, expInc: ExpInc.income, system: true), Category(name: "Аванс", color: UIColor.systemPink, expInc: ExpInc.income, system: true),Category(name: "Грант", color: UIColor.systemRed, expInc: ExpInc.income, system: true),Category(name: "Дивиденды с банковских счетов", color: UIColor.systemBlue, expInc: ExpInc.income, system: true),Category(name: "Зарплата", color: UIColor.systemTeal, expInc: ExpInc.income, system: true),Category(name: "Пенсия", color: UIColor.systemGray, expInc: ExpInc.income, system: true),Category(name: "Подарок", color: UIColor.systemFill, expInc: ExpInc.income, system: true),Category(name: "Помощь", color: UIColor.systemGreen, expInc: ExpInc.income, system: true),Category(name: "Премия", color: UIColor.systemGray2, expInc: ExpInc.income, system: true),Category(name: "Приз", color: UIColor.systemGray3, expInc: ExpInc.income, system: true),Category(name: "Социальная помощь", color: UIColor.systemOrange, expInc: ExpInc.income, system: true),Category(name: "Стипендия", color: UIColor.systemYellow, expInc: ExpInc.income, system: true)]
var categoriesExp: [Category] = [Category(name: "Без категории", color: UIColor.white, expInc: ExpInc.expense, system: true), Category(name: "Автомобиль", color: UIColor.systemIndigo, expInc: ExpInc.expense, system: true),Category(name: "Благотворительность", color: UIColor.systemPurple, expInc: ExpInc.expense, system: true),Category(name: "Бытовая техника", color: UIColor.systemYellow, expInc: ExpInc.expense, system: true),Category(name: "Дети", color: UIColor.systemOrange, expInc: ExpInc.expense, system: true),Category(name: "Домашние животные", color: UIColor.systemGray2, expInc: ExpInc.expense, system: true),Category(name: "Здоровье и красота", color: UIColor.systemFill, expInc: ExpInc.expense, system: true),Category(name: "Долги", color: UIColor.systemTeal, expInc: ExpInc.expense, system: true),Category(name: "Квартира и связь", color: UIColor.systemRed, expInc: ExpInc.expense, system: true),Category(name: "Налоги и стархование", color: UIColor.systemBlue, expInc: ExpInc.expense, system: true),Category(name: "Образование", color: UIColor.systemPink, expInc: ExpInc.expense, system: true),Category(name: "Одежда и аксессуары", color: UIColor.systemGray3, expInc: ExpInc.expense, system: true),Category(name: "Отдых и развлечение", color: UIColor.systemGray5, expInc: ExpInc.expense, system: true),Category(name: "Питание", color: UIColor.secondarySystemGroupedBackground, expInc: ExpInc.expense, system: true),Category(name: "Товары для дома", color: UIColor.tertiarySystemGroupedBackground, expInc: ExpInc.expense, system: true),Category(name: "Транспорт", color: UIColor.tertiarySystemFill, expInc: ExpInc.expense, system: true),Category(name: "Ремонт и мебель", color: UIColor.secondarySystemGroupedBackground, expInc: ExpInc.expense, system: true)]

class CategoryViewController: UIViewController {
    
    var delegateCategoryBudget: CreateBudgetTableViewController?
    
    var delegateChooseCategory: CreateTransactionTableViewController?
    
    @IBOutlet weak var tableView: UITableView!
    
    var indicator: Bool = true
    
    var expInc: ExpInc = ExpInc.expense
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        if expInc != ExpInc.expense{
            categoriesInc  = categoriesInc.sorted { $0.name < $1.name }
        }else{
            categoriesExp  = categoriesExp.sorted { $0.name < $1.name }
        }
        
        if !indicator{
            addCategoryButton.isEnabled = indicator
            addCategoryButton.tintColor = .clear
        }
    }
    
    @IBAction func tappedCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBOutlet weak var addCategoryButton: UIBarButtonItem!
        
    @IBAction func tappedAddCategory(_ sender: UIBarButtonItem) {
        let sb = self.storyboard?.instantiateViewController(identifier: "createCategoryTableViewController") as! CreateCategoryTableViewController
        sb.modalPresentationStyle = .fullScreen
        if colorArray.count == 0{
            messageAlert(title: "Сообщеие", message: "Больше нельзя создавать категории!")
        }else{
            self.present(sb, animated: true)
        }
    }
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        guard let createCategoryVC = segue.source as? CreateCategoryTableViewController else { return }
        if expInc == ExpInc.expense{
            createCategoryVC.saveNewCategory()
            categoriesExp.append(createCategoryVC.category!)
        }else{
            createCategoryVC.saveNewCategory()
            categoriesInc.append(createCategoryVC.category!)
        }
        colorArray.remove(at: createCategoryVC.indexColor!)
        tableView.reloadData()
        self.viewDidLoad()
    }
    
}
extension CategoryViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if expInc == ExpInc.expense{
            if categoriesExp[indexPath.row].system == false{
                let delete = UIContextualAction(style: .destructive, title: "Удалить") { (contextualAction, view, boolValue) in
                        let alert = UIAlertController(title: "Удалить категорию", message: "Вы уверены что хотите удалить категорию \(categoriesExp[indexPath.row].name)?", preferredStyle: .actionSheet)
         
                        let DeleteAction = UIAlertAction(title: "Удалить", style: .default, handler: {
                        action in
                            colorArray.append(categoriesExp[indexPath.row].color)
                            categoriesExp.remove(at: indexPath.row)
                            tableView.reloadData()
                        })
                        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
                        alert.addAction(DeleteAction)
                        alert.addAction(CancelAction)
            
                        self.present(alert, animated: true, completion: nil)
                }

                let edit = UIContextualAction(style: .normal, title: "Изменить") {  (contextualAction, view, boolValue) in
                    let sb = self.storyboard?.instantiateViewController(identifier: "createCategoryTableViewController") as! CreateCategoryTableViewController
                    sb.modalPresentationStyle = .fullScreen
                    self.present(sb, animated: true, completion: nil)
                }

                edit.backgroundColor = UIColor.blue
                let swipeActions = UISwipeActionsConfiguration(actions: [delete, edit])
        
                return swipeActions
            }else{
                return nil
            }
        }else{
            if categoriesInc[indexPath.row].system == false{
                let delete = UIContextualAction(style: .destructive, title: "Удалить") { (contextualAction, view, boolValue) in
                        let alert = UIAlertController(title: "Удалить категорию", message: "Вы уверены что хотите удалить категорию \(categoriesInc[indexPath.row].name)?", preferredStyle: .actionSheet)
         
                        let DeleteAction = UIAlertAction(title: "Удалить", style: .default, handler: {
                        action in
                            colorArray.append(categoriesInc[indexPath.row].color)
                            categoriesInc.remove(at: indexPath.row)
                            tableView.reloadData()
                        })
                        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
                        alert.addAction(DeleteAction)
                        alert.addAction(CancelAction)
            
                        self.present(alert, animated: true, completion: nil)
                }

                let edit = UIContextualAction(style: .normal, title: "Изменить") {  (contextualAction, view, boolValue) in
                    let sb = self.storyboard?.instantiateViewController(identifier: "createCategoryTableViewController") as! CreateCategoryTableViewController
                    sb.modalPresentationStyle = .fullScreen
                    self.present(sb, animated: true, completion: nil)
                }

                edit.backgroundColor = UIColor.blue
                let swipeActions = UISwipeActionsConfiguration(actions: [delete, edit])
        
                return swipeActions
            }else{
                return nil
            }
        }
    }

}
extension CategoryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if expInc == ExpInc.expense{
            return categoriesExp.count
        }else{
            return categoriesInc.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        if expInc == ExpInc.expense{
            cell.nameCategoryLabel.text = categoriesExp[indexPath.row].name
            cell.colorView.backgroundColor = categoriesExp[indexPath.row].color
            if categoriesExp[indexPath.row].system == false{
                cell.accessoryType = .disclosureIndicator
            }
            return cell
        }else{
            cell.nameCategoryLabel.text = categoriesInc[indexPath.row].name
            cell.colorView.backgroundColor = categoriesInc[indexPath.row].color
            if categoriesInc[indexPath.row].system == false{
                cell.accessoryType = .disclosureIndicator
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if expInc == ExpInc.expense{
            delegateCategoryBudget?.updateCategory(category: categoriesExp[indexPath.row])
            delegateChooseCategory?.updateCategory(category: categoriesExp[indexPath.row])
        }else{
            delegateChooseCategory?.updateCategory(category: categoriesInc[indexPath.row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        let verticalPadding: CGFloat = 4
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    func messageAlert(title: String, message: String){
        let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

