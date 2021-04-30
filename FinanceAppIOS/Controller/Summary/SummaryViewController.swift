//
//  SummaryViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 10.12.2020.
//

import UIKit
import Firebase

var globalPurses: [Purse] = []
var chooseIndex: Int?

class SummaryViewController: UIViewController{
    
    @IBOutlet weak var allSumPureLabel: UILabel!
    
    @IBOutlet weak var namePureLabel: UILabel!
    
    @IBOutlet weak var sumPure: UILabel!
    
        
    @IBOutlet weak var contentView: UIView!{
        didSet{
            contentView.layer.cornerRadius = contentView.frame.size.width / 2
            contentView.clipsToBounds = true
            contentView.layer.borderWidth = 2
            contentView.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBOutlet weak var addOrChoosePurse: UIButton!{
        didSet{
            addOrChoosePurse.layer.cornerRadius = addOrChoosePurse.frame.size.width / 2
            addOrChoosePurse.clipsToBounds = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if globalPurses.count != 0{
            var sum: Double = 0.00
            for i in 0...globalPurses.count - 1{
                var sum1: Double = 0.00
                if globalPurses[i].transactions.count != 0{
                    for j in 0...globalPurses[i].transactions.count - 1{
                        if globalPurses[i].transactions[j].expInc == ExpInc.expense{
                            sum1 -= Double(globalPurses[i].transactions[j].sum) ?? 0.00
                        }else{
                            sum1 += Double(globalPurses[i].transactions[j].sum) ?? 0.00
                        }
                    }
                }
                globalPurses[i].sum = String(sum1)
                sum += Double(globalPurses[i].sum) ?? 0.00
            }
            sumPure.text = globalPurses[chooseIndex!].sum
            allSumPureLabel.text = String(sum)
        }
        if globalPurses.count == 0{
            let sb = self.storyboard?.instantiateViewController(identifier: "createPurseTableViewController") as! CreatePurseTableViewController
            sb.indicator = false
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: false)
        }

        if globalPurses.count == 1{
            namePureLabel.text = globalPurses[0].name
            sumPure.text = globalPurses[0].sum
            chooseIndex = 0
        }

        
        // swipe right and left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @IBAction func tappedAddChoosePurse(_ sender: UIButton) {
        let alert = UIAlertController(title: "Кошельки", message: "Выберете кошелек.", preferredStyle: .actionSheet)
        if globalPurses.count != 0{
            for i in 0...globalPurses.count - 1{
                alert.addAction(UIAlertAction(title: globalPurses[i].name + " - " + globalPurses[i].sum, style: .default, handler: {
                    action in
                    let alert1 = UIAlertController(title: "Выбрать действие", message: nil, preferredStyle: .actionSheet)
                    alert1.addAction(UIAlertAction(title: "Выбрать кошелек", style: .default, handler: { action in
                        self.namePureLabel.text = globalPurses[i].name
                        self.sumPure.text = globalPurses[i].sum
                        chooseIndex = i
                    }))
                    alert1.addAction(UIAlertAction(title: "Редактировать кошелек", style: .default, handler: { action in
                        let sb = self.storyboard?.instantiateViewController(identifier: "createPurseTableViewController") as! CreatePurseTableViewController
                        sb.dublicateNamePurseTextField = globalPurses[i].name
                        sb.dublicateChoosePeriodLabel = globalPurses[i].period
                        sb.dublicateChooseCurrencyLabel = globalPurses[i].currency[0]
                        sb.dublicateAddChooseCurrency = globalPurses[i].currency[1]
                        sb.index = i
                        sb.modalPresentationStyle = .fullScreen
                        self.present(sb, animated: true)
                    }))
                    alert1.addAction(UIAlertAction(title: "Удалить кошелек", style: .default, handler: { action in
                        if i == chooseIndex{
                            chooseIndex = 0
                        }
                        globalPurses.remove(at: i)
                        if globalPurses.count == 0{
                            let sb = self.storyboard?.instantiateViewController(identifier: "createPurseTableViewController") as! CreatePurseTableViewController
                            sb.indicator = false
                            sb.modalPresentationStyle = .fullScreen
                            self.present(sb, animated: true)
                        }
                        self.viewDidLoad()
                    }))
                    alert1.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
                    self.present(alert1, animated: true, completion: nil)
                }))
            }
        }
        alert.addAction(UIAlertAction(title: "Создать кошелек+", style: .default, handler: {
            action in
            let sb = self.storyboard?.instantiateViewController(identifier: "createPurseTableViewController") as! CreatePurseTableViewController
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveNewPurse(_ segue: UIStoryboardSegue){
        guard let createPurseTVC = segue.source as? CreatePurseTableViewController else { return }
        if createPurseTVC.index == nil{
            globalPurses.append(Purse(name: createPurseTVC.namePurseTextField.text!, sum: "0.00", period: createPurseTVC.choosePeriodLabel.text!, currency: [createPurseTVC.chooseCurrencyLabel.text!, createPurseTVC.addChooseCurrency!], transactions: [], budgets: [], depts: []))
            chooseIndex = globalPurses.count - 1
            self.namePureLabel.text = globalPurses[chooseIndex!].name
            self.sumPure.text = globalPurses[chooseIndex!].sum
        }else{
            globalPurses[createPurseTVC.index!] = Purse(name: createPurseTVC.namePurseTextField.text!, sum: globalPurses[createPurseTVC.index!].sum, period: createPurseTVC.choosePeriodLabel.text!, currency: [createPurseTVC.chooseCurrencyLabel.text!, createPurseTVC.addChooseCurrency!], transactions: globalPurses[createPurseTVC.index!].transactions, budgets: globalPurses[createPurseTVC.index!].budgets, depts: globalPurses[createPurseTVC.index!].depts)
        }
        viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.viewDidLoad()
        }
    }
    
    
  /*  @IBAction func tappedSelectPhoto(_ sender: UIButton) {
        
        let cameraIcon = #imageLiteral(resourceName: "camera")
        let photoIcon = #imageLiteral(resourceName: "photo")
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.shooseImagePicker(sourse: .camera)
        }
        camera.setValue(cameraIcon, forKey: "image")
        camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let photo = UIAlertAction(title: "Photo", style: .default){ _ in
            self.shooseImagePicker(sourse: .photoLibrary)
        }
        photo.setValue(photoIcon, forKey: "image")
        photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    } */
    
    // MARK: Work with navigation
    
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
    
    @IBAction func addPurseButton(_ sender: UIBarButtonItem) {
        let sb = self.storyboard?.instantiateViewController(identifier: "createPurseTableViewController") as! CreatePurseTableViewController
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true)
    }
    
    
    @IBAction func tappedExit(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Выход" , message: "Вы действительно хотите выйти?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            action in
            do{
                try Auth.auth().signOut()
            }catch{
                print(error.localizedDescription)
            }
            let sb = self.storyboard?.instantiateViewController(identifier: "viewController") as! ViewController
            sb.emailTextField?.text = ""
            sb.passwordTextField?.text = ""
            sb.modalPresentationStyle = .fullScreen
            self.present(sb, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}
extension SummaryViewController: UITableViewDelegate{
    
}
extension SummaryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "summaryTableViewCell", for: indexPath) as! SummaryTableViewCell
        return cell
    }

}


// MARK: Work with image

/* extension SummaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func shooseImagePicker(sourse: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourse){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourse
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoImage.image = info[.editedImage] as? UIImage
        photoImage.contentMode = .scaleAspectFill
        photoImage.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }

} */

