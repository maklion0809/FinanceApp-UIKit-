//
//  SettingTableViewController.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 19.01.2021.
//

import UIKit
import Firebase

class SettingTableViewController: UITableViewController {

    @IBAction func tappedExitApplication(_ sender: UIButton) {
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
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }else{
            return 1
        }
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
    
    @IBAction func tappedCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}
