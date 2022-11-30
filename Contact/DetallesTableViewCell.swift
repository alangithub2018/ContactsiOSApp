//
//  DetallesTableViewCell.swift
//  Contact
//
//  Created by MacBookAir on 26/11/22.
//

import UIKit

class DetallesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var detailNameLabel : UILabel!
    @IBOutlet weak var detailEmailLabel : UILabel!
    @IBOutlet weak var detailTelefonoLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //portraitImageView.image = UIImage(named: "noImage")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
