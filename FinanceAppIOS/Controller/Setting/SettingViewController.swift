//
//  SettingViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 10.12.2020.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {
    
    @IBOutlet weak var buttonToOut: UIButton!{
        didSet{
            buttonToOut.layer.borderWidth = 2
            buttonToOut.layer.borderColor = (UIColor(red: 242.0/255.0, green: 116.0/255.0, blue: 119.0/255.0, alpha: 1.0)).cgColor
            buttonToOut.layer.cornerRadius = 5
            buttonToOut.clipsToBounds = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tappedCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedToOut(_ sender: UIButton) {
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
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
