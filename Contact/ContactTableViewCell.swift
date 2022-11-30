//
//  ContactTableViewCell.swift
//  Contact
//
//  Created by MacBookAir on 26/11/22.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
