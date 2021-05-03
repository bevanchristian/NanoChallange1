//
//  ViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 27/04/21.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, kirimNotif {
    
    
    func send() {
        print("protocol")
        performSelector(inBackground: #selector(manggilData), with: nil)
    }
    
 
    

    @IBOutlet var collectionViewProfesional: UICollectionView!
    @IBOutlet var collectionViewDesign: UICollectionView!
    
    @IBOutlet var collectionView: UICollectionView!
    let elearn = elearnData()
    let hasilJson:dataExplor! = nil
    var dataFix = [elearnModel]()
    var dataFixDesign = [elearnModel]()
    var dataFixPro = [elearnModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Learning Explorer"
    
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionViewDesign.delegate = self
        collectionViewDesign.dataSource = self
        
        collectionViewProfesional.delegate = self
        collectionViewProfesional.dataSource = self
        performSelector(inBackground: #selector(manggilData), with: nil)
        
    

        NotificationCenter.default.addObserver(forName: NSNotification.Name("API"), object: nil, queue: OperationQueue.main) { [self] (notification) in
            let elearnVC = notification.object as?  elearnData
            dataFix = elearn.dataFix
            dataFixDesign = elearn.dataFixDesign
            dataFixPro = elearn.dataFixPro
            self.collectionView.reloadData()
            self.collectionViewDesign.reloadData()
            self.collectionViewProfesional.reloadData()
            
  
            
            print("a")
        }

    }
    
    
   
    @objc func manggilData(){
        elearn.GetData(myview: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = (storyboard?.instantiateViewController(identifier: "detail"))! as DetailViewController
        cell.delegate2 = self
        cell.home = self
        cell.urutan = indexPath
       if collectionView == self.collectionView{
        /*cell.fotoUser = dataFix[indexPath.row].photo
        
        if (dataFix[indexPath.row].photo) != nil{
            if let datafoto = try? Data(contentsOf: (URL(string: (dataFix[indexPath.row].photo as? String)!) ?? URL(string: "https://dl.airtable.com/.attachments/793d85215a4c8118e5c815854d5b3725/0ceb3359/FelindaGracia.jpg"))! ) {
                   if let foto = UIImage(data: datafoto) {
                    cell.fotoUser = foto
                 
                   }
               }
           }*/
        cell.expertiseUser = dataFix[indexPath.row].expertise
        cell.maubelajarapaUser = dataFix[indexPath.row].belajar
        cell.namaUser = dataFix[indexPath.row].nama
        cell.pointUser = dataFix[indexPath.row].point
        cell.skillUser = dataFix[indexPath.row].skill
        cell.id = dataFix[indexPath.row].id
        cell.tipe = 1
    
        
     
            
            
        }else if collectionView == self.collectionViewDesign{
           // cell.fotoUser = dataFixDesign[indexPath.row].photo
            cell.expertiseUser = dataFixDesign[indexPath.row].expertise
            cell.maubelajarapaUser = dataFixDesign[indexPath.row].belajar
            cell.namaUser = dataFixDesign[indexPath.row].nama
            cell.pointUser = dataFixDesign[indexPath.row].point
            cell.skillUser = dataFixDesign[indexPath.row].skill
            cell.id = dataFixDesign[indexPath.row].id
            cell.tipe = 2
        }else{
            
           //cell.fotoUser = dataFixPro[indexPath.row].photo
            cell.expertiseUser = dataFixPro[indexPath.row].expertise
            cell.maubelajarapaUser = dataFixPro[indexPath.row].belajar
            cell.namaUser = dataFixPro[indexPath.row].nama
            cell.pointUser = dataFixPro[indexPath.row].point
            cell.skillUser = dataFixPro[indexPath.row].skill
            cell.id = dataFixPro[indexPath.row].id
            cell.tipe = 3
        }
        
        
        
        navigationController?.pushViewController(cell, animated: true)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionView{
            return dataFix.count
        }else if collectionView == self.collectionViewDesign {
            return dataFixDesign.count
        }else{
            return dataFixPro.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HomeCollectionViewCell
            cell?.Skill.text = dataFix[indexPath.row].nama
          //  cell?.foto.image = dataFix[indexPath.row].photo
            cell?.skill2.text = dataFix[indexPath.row].skill
            /*self.layer.shadowColor = [[UIColor blackColor] CGColor];
            self.layer.shadowRadius = 5;
            self.layer.shadowOpacity = .25;*/

            cell?.layer.shadowColor = UIColor.gray.cgColor
            cell?.layer.shadowRadius = 1
            cell?.layer.shadowOpacity = 0.25
            cell?.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            cell?.clipsToBounds = false
            cell?.layer.masksToBounds = false
            
           /* if (dataFix[indexPath.row].photo) != nil{
                if let datafoto = try? Data(contentsOf: (URL(string: (dataFix[indexPath.row].photo as? String)!) ?? URL(string: "https://dl.airtable.com/.attachments/793d85215a4c8118e5c815854d5b3725/0ceb3359/FelindaGracia.jpg"))! ) {
                       if let foto = UIImage(data: datafoto) {
                        cell?.foto.image = foto
                        collectionView.reloadData()
                       }
                   }
               }*/
            //cell?.foto.image = UIImage(named: "Leaderboard Copy")
            print("jancok")
            print( dataFix[indexPath.row].photo)
            cell?.foto.downloadImageFrom(link: dataFix[indexPath.row].photo, contentMode: UIView.ContentMode.scaleAspectFit)
            
           
               //let recordID = CKRecord.ID(recordName: model.nama)
              
               
           
            cell?.foto.layer.borderWidth = 1
            cell?.foto.layer.masksToBounds = false
            //cell?.foto.layer.borderColor = UIColor.black.cgColor
            cell?.foto.layer.cornerRadius = (cell?.foto.frame.height)!/2
            cell?.foto.clipsToBounds = true
            return cell!
        }else if collectionView == self.collectionViewDesign {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celldesign", for: indexPath) as? HomeDesignCollectionViewCell
            cell?.Skill.text = dataFixDesign[indexPath.row].nama
           // cell?.foto.image = dataFixDesign[indexPath.row].photo
            cell?.skill2.text = dataFixDesign[indexPath.row].skill
            cell?.layer.shadowColor = UIColor.gray.cgColor
            cell?.layer.shadowRadius = 4
            cell?.layer.shadowOpacity = 0.25
            cell?.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            cell?.clipsToBounds = false
            cell?.layer.masksToBounds = false
            
            
            cell?.foto.layer.borderWidth = 1
            cell?.foto.layer.masksToBounds = false
            //cell?.foto.layer.borderColor = UIColor.black.cgColor
            cell?.foto.layer.cornerRadius = (cell?.foto.frame.height)!/2
            cell?.foto.clipsToBounds = true
            return cell!
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellprofesional", for: indexPath) as? HomeProfesionalCollectionViewCell
            cell?.Skill.text = dataFixPro[indexPath.row].nama
            //cell?.foto.image = dataFixPro[indexPath.row].photo
            cell?.skill2.text = dataFixPro[indexPath.row].skill
            cell?.layer.shadowColor = UIColor.gray.cgColor
            cell?.layer.shadowRadius = 4
            cell?.layer.shadowOpacity = 0.25
            cell?.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            cell?.clipsToBounds = false
            cell?.layer.masksToBounds = false
            
            
            cell?.foto.layer.borderWidth = 1
            cell?.foto.layer.masksToBounds = false
            //cell?.foto.layer.borderColor = UIColor.black.cgColor
            cell?.foto.layer.cornerRadius = (cell?.foto.frame.height)!/2
            cell?.foto.clipsToBounds = true
            return cell!
            
        }

    
    }
    
 


}

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
