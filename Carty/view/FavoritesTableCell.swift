//
//  FavoritesTableCell.swift
//  Carty
//
//  Created by Jimmy on 01/09/2023.
//

import UIKit

class FavoritesTableCell: UITableViewCell {


    @IBOutlet weak var favImage: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .systemGray4
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        favImage.layer.cornerRadius = favImage.frame.height / 2
        favImage.layer.borderWidth = 2
        favImage.layer.borderColor = UIColor.black.cgColor
    }

}
