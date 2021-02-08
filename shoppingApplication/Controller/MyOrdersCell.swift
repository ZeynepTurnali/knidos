//
//  MyOrdersCell.swift
//  shoppingApplication

import UIKit

class MyOrdersCell: UITableViewCell {

    @IBOutlet weak var orderImage: LazyImageView!
    @IBOutlet weak var orderNameText: UILabel!
    @IBOutlet weak var orderPriceText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
