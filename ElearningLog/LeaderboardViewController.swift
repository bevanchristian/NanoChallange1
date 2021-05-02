//
//  LeaderboardViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 02/05/21.
//

import UIKit

class LeaderboardViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
   
    

    @IBOutlet var leaderboardCollectionView: UICollectionView!
    let elearn = elearnData()
    var dataFix = [elearnModel]()
    var dataFixDesign = [elearnModel]()
    var dataFixPro = [elearnModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderboardCollectionView.delegate = self
        leaderboardCollectionView.dataSource = self
        title = "Leaderboard"
        performSelector(inBackground: #selector(manggilData), with: nil)
        NotificationCenter.default.addObserver(forName: NSNotification.Name("API"), object: nil, queue: OperationQueue.main) { [self] (notification) in
            let elearnVC = notification.object as?  elearnData
            dataFix = elearn.dataFix
            dataFixDesign = elearn.dataFixDesign
            dataFixPro = elearn.dataFixPro
            self.leaderboardCollectionView.reloadData()
   
            
  
            
            print("a")
        }

        // Do any additional setup after loading the view.
    }
    @objc func manggilData(){
        elearn.it(leaderboard: true)
        elearn.design(leaderboard: true)
        elearn.pro(leaderboard: true)
    
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFixPro.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leaderboardcell", for: indexPath) as! LeaderboardCollectionViewCell
        cell.nama.text = dataFixPro[indexPath.row].nama
        cell.point.text = dataFixPro[indexPath.row].point
        cell.urutan.text = String(indexPath.row)
        return cell
    }
    

    

}
