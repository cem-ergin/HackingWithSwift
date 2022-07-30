//
//  PictureTableViewCell.swift
//  Milestone Project 10-12 Captionable Pictures
//
//  Created by Cem Ergin on 30/07/2022.
//

import UIKit

class PictureTableViewCell: UITableViewCell {
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var imageTitleLabelView: UILabel!
    @IBOutlet var imageCaptionLabelView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
