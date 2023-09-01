//
//  ProductTableCell.swift
//  Carty
//
//  Created by Jimmy on 30/08/2023.
//

import UIKit

class ProductTableCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .systemGray4
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        productImage.layer.cornerRadius = productImage.frame.height / 2
        productImage.layer.borderWidth = 2
        productImage.layer.borderColor = UIColor.black.cgColor
    }

}
