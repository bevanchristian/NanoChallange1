//
//  LeaderboardCollectionViewCell.swift
//  ElearningLog
//
//  Created by bevan christian on 02/05/21.
//

import UIKit

class LeaderboardCollectionViewCell: UICollectionViewCell {
    @IBOutlet var urutan: UILabel!
    @IBOutlet var foto: UIImageView!
    @IBOutlet var nama: UILabel!
    @IBOutlet var point: UILabel!
    
    
    override func layoutSubviews() {
            self.layer.cornerRadius = 10
        }
    
}



