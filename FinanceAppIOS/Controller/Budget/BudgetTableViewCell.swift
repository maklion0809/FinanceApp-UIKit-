//
//  BudgetTableViewCell.swift
//  FinanceAppIOS
//
//  Created by Тимофей on 13.12.2020.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameBudgetLabel: UILabel!
    
    @IBOutlet weak var periodLabel: UILabel!
    
    @IBOutlet weak var endSumLabel: UILabel!
    
    @IBOutlet weak var currentSumLabel: UILabel!
    
    @IBOutlet weak var progeressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        progeressView.transform = progeressView.transform.scaledBy(x: 1, y: 6)
        progeressView.progress = 0.0
        progeressView.layer.cornerRadius = 3
        progeressView.clipsToBounds = true
        progeressView.layer.sublayers![1].cornerRadius = 3
        progeressView.subviews[1].clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
