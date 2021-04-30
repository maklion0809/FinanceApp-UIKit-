//
//  CreateCategoryTableViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 15.01.2021.
//

import UIKit

var colorArray: [UIColor] = [ UIColor.systemGray, UIColor.blue, UIColor.brown, UIColor.cyan, UIColor.green, UIColor.magenta, UIColor.orange, UIColor.purple, UIColor.red, UIColor.yellow]

class CreateCategoryTableViewController: UITableViewController {
    
    
    var category: Category?
    
    var indexColor: Int?
        
    var categoryColor: UIColor?

    @IBOutlet weak var saveCategoryButton: UIBarButtonItem!
    
    @IBOutlet weak var nameCategoryTextField: UITextField!{
        didSet{
            nameCategoryTextField.attributedPlaceholder = NSAttributedString(string: "Введите название", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryColor = colorArray[0]
        indexColor = 0
        
        saveCategoryButton.isEnabled = false
        
        nameCategoryTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    }

    @IBAction func tappedCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
}

extension CreateCategoryTableViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 10, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionViewCell", for: indexPath)
        
        cell.backgroundColor = colorArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell : UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        selectedCell.layer.borderWidth = 4
        categoryColor = colorArray[indexPath.row]
        indexColor = indexPath.row
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let unselectedCell : UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        unselectedCell.layer.borderWidth = 0
    }
    
    func saveNewCategory(){
        category = Category(name: nameCategoryTextField.text!, color: categoryColor!, expInc: ExpInc.expense, system: false)
    }
    
}
extension CreateCategoryTableViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChange(){
        if nameCategoryTextField.text?.isEmpty == false{
            saveCategoryButton.isEnabled = true
        }else{
            saveCategoryButton.isEnabled = false
        }
    }
}
