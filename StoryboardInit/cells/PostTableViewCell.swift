//
//  PostTableViewCell.swift
//  StoryboardInit
//
//  Created by Shohjahon Numonovich on 6/15/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var numberL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
