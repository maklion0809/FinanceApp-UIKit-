//
//  ViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 09.12.2020.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(kdDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kdDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        warnLabel.alpha = 0
        
        Auth.auth().addStateDidChangeListener({ [weak self] (auth, user) in
            if user != nil{
                let sb = self?.storyboard?.instantiateViewController(identifier: "tabBarController") as! TabBarController
                sb.modalPresentationStyle = .fullScreen
                self?.present(sb, animated: false)
            }
        })
        
    }

    @objc func kdDidShow(notification: Notification){
        guard let userInfo = notification.userInfo else {return}
        let kdFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kdFrameSize.height)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kdFrameSize.height, right: 0)
    }
    
    @objc func kdDidHide(){
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    func displayWarningLabel(withText text: String){
        warnLabel.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            self?.warnLabel.alpha = 1
        }){ [] complete in
            self.warnLabel.alpha = 0
        }
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] (user, error) in
            if error != nil{
                self?.displayWarningLabel(withText: "Error occured")
                return
            }
            if user != nil{
                let sb = self?.storyboard?.instantiateViewController(identifier: "tabBarController") as! TabBarController
                sb.modalPresentationStyle = .fullScreen
                self?.present(sb, animated: true)
                return
            }
            self?.displayWarningLabel(withText: "No such user")
        })
    }
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                if user != nil{
                    let sb = self.storyboard?.instantiateViewController(identifier: "createPurseTableViewController") as! CreatePurseTableViewController
                    sb.indicator = false
                    sb.modalPresentationStyle = .fullScreen
                    self.present(sb, animated: true)
                }else{
                    print("user in not creater")
                }
            }else{
                print(error!.localizedDescription)
            }
            
        })
    }
}

