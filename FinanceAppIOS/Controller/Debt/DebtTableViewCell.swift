//
//  DebtTableViewCell.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 13.12.2020.
//

import UIKit

class DebtTableViewCell: UITableViewCell {

    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var dateReturnLabel: UILabel!
    
    @IBOutlet weak var whoAndWhomLabel: UILabel!
    
    @IBOutlet weak var sumDebtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
