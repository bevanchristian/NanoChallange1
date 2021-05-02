//
//  LeaderboardViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 02/05/21.
//

import UIKit

class LeaderboardViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
   
    

    @IBOutlet var leaderboardCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardCollectionView.delegate = self
        leaderboardCollectionView.dataSource = self
        title = "Leaderboard"

        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leaderboardcell", for: indexPath) as! LeaderboardCollectionViewCell
        
        return cell
    }
    

    

}
