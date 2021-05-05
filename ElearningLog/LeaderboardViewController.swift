//
//  LeaderboardViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 02/05/21.
//

import UIKit
import Alamofire
import AlamofireImage
class LeaderboardViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
   
    

    @IBOutlet var leaderboardCollectionView: UICollectionView!
    let elearn = elearnData()
    var dataFix = [elearnModel]()
    var dataFixDesign = [elearnModel]()
    var dataFixPro = [elearnModel]()
    var kategori = 0
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
    @IBAction func kategori(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            //it
         kategori = 0
            UIView.animate(withDuration: 0.25) {
                self.leaderboardCollectionView.reloadData()
            }
            
        }
        else if sender.selectedSegmentIndex == 1{
            //design
         kategori = 1
            UIView.animate(withDuration: 0.25) {
                self.leaderboardCollectionView.reloadData()
            }
            
        }else{
            //profesional
            
         kategori = 2
            UIView.animate(withDuration: 0.25) {
                self.leaderboardCollectionView.reloadData()
            }
            
        }
    }
    @objc func manggilData(){
        elearn.it(leaderboard: true)
        elearn.design(leaderboard: true)
        elearn.pro(leaderboard: true)
    
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if kategori == 0{
            return dataFix.count
        }else if kategori == 1{
            return dataFixDesign.count
        }else{
            return dataFixPro.count
        }
 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leaderboardcell", for: indexPath) as! LeaderboardCollectionViewCell
        
        if kategori == 0{
 
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: cell.foto.frame.size,
                radius: 18
            )
            if let imageUrl =  URL(string: dataFix[indexPath.row].photo){
                cell.foto.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "image_large"),filter: filter)}
//            cell.layer.shadowColor = UIColor.gray.cgColor
//            cell.layer.shadowRadius = 4
//            cell.layer.shadowOpacity = 0.25
//            cell.layer.shadowOffset = CGSize(width: 0, height: 3.0)
//            cell.clipsToBounds = false
//            cell.layer.masksToBounds = false
//            cell.layer.cornerRadius = 6
            cell.nama.text = dataFix[indexPath.row].nama
            cell.point.text = dataFix[indexPath.row].point
            cell.urutan.text = String(indexPath.row + 1)
            return cell
        }else if kategori == 1{
           /* DispatchQueue.global(qos: .default).async { [self] in
            
      
                if let imageCache = dataFixDesign[indexPath.row].imagecache{
                    DispatchQueue.main.async {
                        cell.foto.image = imageCache
                    }
 
                }else {
                    let downloader = ImageDownloader(
                        configuration: ImageDownloader.defaultURLSessionConfiguration(),
                        downloadPrioritization: .fifo,
                        maximumActiveDownloads: 20,
                        imageCache: AutoPurgingImageCache()
                    )
                    let urlRequest = URLRequest(url: URL(string: dataFixDesign[indexPath.row].photo)!)

                    downloader.download(urlRequest, completion:  { [self] response in
                        print(response.request)
                        print(response.response)
                        debugPrint(response.result)
                        
                        if case .success(let image) = response.result {
                            dataFixDesign[indexPath.row].imagecache = image
                            DispatchQueue.main.async {
                                cell.foto.image = image
                            }
                
                        }
                    })
                }
                
            }*/
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: cell.foto.frame.size,
                radius: 18
            )
            if let imageUrl =  URL(string: dataFixDesign[indexPath.row].photo){
                cell.foto.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "image_large"),filter: filter)}
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowRadius = 4
            cell.layer.shadowOpacity = 0.25
            cell.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            cell.clipsToBounds = false
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 6
            cell.nama.text = dataFixDesign[indexPath.row].nama
            cell.point.text = dataFixDesign[indexPath.row].point
            cell.urutan.text = String(indexPath.row + 1)
            return cell
        }else{
        /*    DispatchQueue.global(qos: .default).async { [self] in
            
      
                if let imageCache = dataFixPro[indexPath.row].imagecache{
                    DispatchQueue.main.async {
                        cell.foto.image = imageCache
                    }
 
                }else {
                    let downloader = ImageDownloader(
                        configuration: ImageDownloader.defaultURLSessionConfiguration(),
                        downloadPrioritization: .fifo,
                        maximumActiveDownloads: 20,
                        imageCache: AutoPurgingImageCache()
                    )
                    let urlRequest = URLRequest(url: URL(string: dataFixPro[indexPath.row].photo)!)

                    downloader.download(urlRequest, completion:  { [self] response in
                        print(response.request)
                        print(response.response)
                        debugPrint(response.result)
                        
                        if case .success(let image) = response.result {
                            dataFixPro[indexPath.row].imagecache = image
                            DispatchQueue.main.async {
                                cell.foto.image = image
                            }
                
                        }
                    })
                }
                
            }*/
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: cell.foto.frame.size,
                radius: 18
            )
            if let imageUrl =  URL(string: dataFixPro[indexPath.row].photo){
                cell.foto.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "image_large"),filter: filter)}
          
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowRadius = 4
            cell.layer.shadowOpacity = 0.25
            cell.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            cell.clipsToBounds = false
            cell.layer.masksToBounds = false
            cell.layer.cornerRadius = 6
            cell.nama.text = dataFixPro[indexPath.row].nama
            cell.point.text = dataFixPro[indexPath.row].point
            cell.urutan.text = String(indexPath.row + 1)
            return cell
        }
      
    }
    

    

}
