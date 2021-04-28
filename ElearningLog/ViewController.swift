//
//  ViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 27/04/21.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
 
    

    @IBOutlet var collectionViewDesign: UICollectionView!
    
    @IBOutlet var collectionView: UICollectionView!
    let elearn = elearnData()
    let hasilJson:dataExplor! = nil
    var dataFix = [elearnModel]()
    var dataFixDesign = [elearnModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Learning Explorer"
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionViewDesign.delegate = self
        collectionViewDesign.dataSource = self
        
        performSelector(inBackground: #selector(manggilData), with: nil)

        NotificationCenter.default.addObserver(forName: NSNotification.Name("API"), object: nil, queue: OperationQueue.main) { [self] (notification) in
            let elearnVC = notification.object as?  elearnData
            dataFix = elearn.dataFix
            dataFixDesign = elearn.dataFixDesign
            self.collectionView.reloadData()
            self.collectionViewDesign.reloadData()
            
            print("a")
        }

    }
    
    @objc func manggilData(){
        elearn.GetData(myview: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = storyboard?.instantiateViewController(identifier: "detail")
        
        navigationController?.pushViewController(cell!, animated: true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionView{
            return dataFix.count
        }else {
            return dataFixDesign.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell
            cell?.Skill.text = dataFix[indexPath.row].nama
            cell?.foto.image = dataFix[indexPath.row].photo
            cell?.foto.layer.borderWidth = 1
            cell?.foto.layer.masksToBounds = false
            //cell?.foto.layer.borderColor = UIColor.black.cgColor
            cell?.foto.layer.cornerRadius = (cell?.foto.frame.height)!/2
            cell?.foto.clipsToBounds = true
            
          
            
            
            
            
            return cell!
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celldesign", for: indexPath) as? HomeDesignCollectionViewCell
            cell?.Skill.text = dataFixDesign[indexPath.row].nama
            cell?.foto.image = dataFixDesign[indexPath.row].photo
            cell?.foto.layer.borderWidth = 1
            cell?.foto.layer.masksToBounds = false
            //cell?.foto.layer.borderColor = UIColor.black.cgColor
            cell?.foto.layer.cornerRadius = (cell?.foto.frame.height)!/2
            cell?.foto.clipsToBounds = true
            return cell!
        }
    
    }
    
 


}

