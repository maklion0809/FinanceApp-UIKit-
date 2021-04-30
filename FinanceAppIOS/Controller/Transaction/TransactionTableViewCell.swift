//
//  TransactionTableViewCell.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 13.12.2020.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var sumLabel: UILabel!
    
    @IBOutlet weak var typeCategoryLabel: UILabel!
    
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var colorCategoryView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
