//
//  ViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 27/04/21.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
 
    


    @IBOutlet var collectionView: UICollectionView!
    let elearn = elearnData()
    let hasilJson:dataExplor! = nil
    var dataFix = [elearnModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Learning Explorer"
        collectionView.delegate = self
        collectionView.dataSource = self
        elearn.GetData(myview: self)
        NotificationCenter.default.addObserver(forName: NSNotification.Name("API"), object: nil, queue: OperationQueue.main) { [self] (notification) in
            let elearnVC = notification.object as?  elearnData
           dataFix = elearn.dataFix
            self.collectionView.reloadData()
            
            print("a")
        }

    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFix.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell
        cell?.Skill.text = dataFix[indexPath.row].nama
        
        
        
        
        return cell!
    }
    
 


}

