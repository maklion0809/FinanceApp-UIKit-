//
//  TransactionDiagramTableViewCell.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 19.01.2021.
//

import UIKit

class TransactionDiagramTableViewCell: UITableViewCell {

    @IBOutlet weak var nameCategoryTransaction: UILabel!
    
    @IBOutlet weak var generalSumTransaction: UILabel!
    
    @IBOutlet weak var colorCategoryTransaction: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
