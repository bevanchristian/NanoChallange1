//
//  ResourceTableViewCell.swift
//  ElearningLog
//
//  Created by bevan christian on 05/05/21.
//

import UIKit

class ResourceTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var subs: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
