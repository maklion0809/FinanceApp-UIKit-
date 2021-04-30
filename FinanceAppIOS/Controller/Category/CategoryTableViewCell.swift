//
//  CategoryTableViewCell.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 14.01.2021.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var nameCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
