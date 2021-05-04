//
//  ViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 27/04/21.
//

import UIKit
import Alamofire
import AlamofireImage
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, kirimNotif {
    
    
    func send() {
        print("protocol")
        performSelector(inBackground: #selector(manggilData), with: nil)
    }
    
 
    
    @IBOutlet var scroll: UIScrollView!
    
    @IBOutlet var collectionViewProfesional: UICollectionView!
    @IBOutlet var collectionViewDesign: UICollectionView!
    
    @IBOutlet var collectionView: UICollectionView!
    let elearn = elearnData()
    let hasilJson:dataExplor! = nil
    var dataFix = [elearnModel]()
    var dataFixDesign = [elearnModel]()
    var dataFixPro = [elearnModel]()
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Learning Explorer"
      
        configureRefreshControl()
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
    @objc func refresh(_ sender: AnyObject) {
        self.collectionView.reloadData()
        self.collectionViewDesign.reloadData()
        self.collectionViewProfesional.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    func configureRefreshControl () {
       // Add the refresh control to your UIScrollView object.
       scroll.refreshControl = UIRefreshControl()
       scroll.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }

    @objc func handleRefreshControl() {
       // Update your content…

       // Dismiss the refresh control.
       DispatchQueue.main.async {
      
            self.collectionView.reloadData()
            self.collectionViewDesign.reloadData()
            self.collectionViewProfesional.reloadData()
            self.scroll.refreshControl?.endRefreshing()
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
        cell.fotoUser = dataFix[indexPath.row].photo
 
        cell.expertiseUser = dataFix[indexPath.row].expertise
        cell.maubelajarapaUser = dataFix[indexPath.row].belajar
        cell.namaUser = dataFix[indexPath.row].nama
        cell.pointUser = dataFix[indexPath.row].point
        cell.skillUser = dataFix[indexPath.row].skill
        cell.id = dataFix[indexPath.row].id
        cell.tipe = 1
    
        
     
            
            
        }else if collectionView == self.collectionViewDesign{
            cell.fotoUser = dataFixDesign[indexPath.row].photo
            cell.expertiseUser = dataFixDesign[indexPath.row].expertise
            cell.maubelajarapaUser = dataFixDesign[indexPath.row].belajar
            cell.namaUser = dataFixDesign[indexPath.row].nama
            cell.pointUser = dataFixDesign[indexPath.row].point
            cell.skillUser = dataFixDesign[indexPath.row].skill
            cell.id = dataFixDesign[indexPath.row].id
            cell.tipe = 2
        }else{
            
       
            cell.fotoUser = dataFixPro[indexPath.row].photo
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
            cell?.skill2.text = dataFix[indexPath.row].skill
            cell?.foto.image = nil
            
          /*  DispatchQueue.global(qos: .default).async { [self] in
            
      
                if let imageCache = dataFix[indexPath.row].imagecache{
                    DispatchQueue.main.async {
                        cell?.foto.image = imageCache
                    }
 
                }else {
                    let downloader = ImageDownloader(
                        configuration: ImageDownloader.defaultURLSessionConfiguration(),
                        downloadPrioritization: .fifo,
                        maximumActiveDownloads: 20,
                        imageCache: AutoPurgingImageCache()
                    )
                    let urlRequest = URLRequest(url: URL(string: dataFix[indexPath.row].photo)!)

                    downloader.download(urlRequest, completion:  { [self] response in
                        print(response.request)
                        print(response.response)
                        debugPrint(response.result)
                        
                        if case .success(let image) = response.result {
                            dataFix[indexPath.row].imagecache = image
                            DispatchQueue.main.async {
                                cell?.foto.image = image
                            }
                
                        }
                    })
                }
                
            }*/
           
/*    let downloader = ImageDownloader(configuration: ImageDownloader.defaultURLSessionConfiguration(), downloadPrioritization: .lifo, maximumActiveDownloads: 5, imageCache: AutoPurgingImageCache())
            let urlRequest = URLRequest(url: URL(string: dataFix[indexPath.row].photo)!)

            downloader.download(urlRequest, completion:  { response in
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                
                if case .success(let image) = response.result {
                    cell?.foto.image = image
                }
            }) */
            
            if let imageUrl =  URL(string: dataFix[indexPath.row].photo){
                                    cell?.foto.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "defaultImage"))
                                }

            cell?.foto.layer.cornerRadius = (cell?.foto.frame.size.width)! / 2
            cell?.foto.clipsToBounds = true
            cell?.foto.layer.borderWidth = 2
            cell?.foto.layer.borderColor = UIColor.white.cgColor
            cell?.layer.shadowColor = UIColor.gray.cgColor
            cell?.layer.shadowRadius = 1
            cell?.layer.shadowOpacity = 0.25
            cell?.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            cell?.clipsToBounds = false
            cell?.layer.masksToBounds = false
            cell?.layer.cornerRadius = 6

            
           
           
               //let recordID = CKRecord.ID(recordName: model.nama)
              
               
           
          /*  cell?.foto.layer.borderWidth = 1
            cell?.foto.layer.masksToBounds = false
            //cell?.foto.layer.borderColor = UIColor.black.cgColor
            cell?.foto.layer.cornerRadius = (cell?.foto.frame.height)!/2
            cell?.foto.clipsToBounds = true*/
            return cell!
        }else if collectionView == self.collectionViewDesign {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celldesign", for: indexPath) as? HomeDesignCollectionViewCell
            cell?.Skill.text = dataFixDesign[indexPath.row].nama
          
            
           /* DispatchQueue.global(qos: .default).async { [self] in
            
      
                if let imageCache = dataFixDesign[indexPath.row].imagecache{
                    DispatchQueue.main.async {
                        cell!.foto.image = imageCache
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
                                cell!.foto.image = image
                            }
                
                        }
                    })
                }
                
            }*/
            if let imageUrl =  URL(string: dataFixDesign[indexPath.row].photo){
                                    cell?.foto.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "defaultImage"))
                                }
            
            cell?.foto.layer.cornerRadius = (cell?.foto.frame.size.width)! / 2
            cell?.foto.clipsToBounds = true
            cell?.foto.layer.borderWidth = 2
            cell?.foto.layer.borderColor = UIColor.white.cgColor

            cell?.skill2.text = dataFixDesign[indexPath.row].skill
            cell?.layer.shadowColor = UIColor.gray.cgColor
            cell?.layer.shadowRadius = 4
            cell?.layer.shadowOpacity = 0.25
            cell?.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            cell?.clipsToBounds = false
            cell?.layer.masksToBounds = false
            cell?.layer.cornerRadius = 6
            
            /*    cell?.foto.layer.borderWidth = 1
            cell?.foto.layer.masksToBounds = false
            //cell?.foto.layer.borderColor = UIColor.black.cgColor
            cell?.foto.layer.cornerRadius = (cell?.foto.frame.height)!/2
            cell?.foto.clipsToBounds = true */
            return cell!
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellprofesional", for: indexPath) as? HomeProfesionalCollectionViewCell
            cell?.Skill.text = dataFixPro[indexPath.row].nama
            //cell?.foto.image = dataFixPro[indexPath.row].photo
            
          /*  DispatchQueue.global(qos: .default).async { [self] in
            
      
                if let imageCache = dataFixPro[indexPath.row].imagecache{
                    DispatchQueue.main.async {
                        cell!.foto.image = imageCache
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
                                cell!.foto.image = image
                            }
                
                        }
                    })
                }
                
            }*/
            
            
            
            if let imageUrl =  URL(string: dataFixPro[indexPath.row].photo){
                                    cell?.foto.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "defaultImage"))
                                }
            
            cell?.foto.layer.cornerRadius = (cell?.foto.frame.size.width)! / 2
            cell?.foto.clipsToBounds = true
            cell?.foto.layer.borderWidth = 2
            cell?.foto.layer.borderColor = UIColor.white.cgColor
            cell?.skill2.text = dataFixPro[indexPath.row].skill
            cell?.layer.shadowColor = UIColor.gray.cgColor
            cell?.layer.shadowRadius = 4
            cell?.layer.shadowOpacity = 0.25
            cell?.layer.shadowOffset = CGSize(width: 0, height: 3.0)
            cell?.clipsToBounds = false
            cell?.layer.masksToBounds = false
            cell?.layer.cornerRadius = 6
            
            /*   cell?.foto.layer.borderWidth = 1
            cell?.foto.layer.masksToBounds = false
            //cell?.foto.layer.borderColor = UIColor.black.cgColor
            cell?.foto.layer.cornerRadius = (cell?.foto.frame.height)!/2
            cell?.foto.clipsToBounds = true */
            return cell!
            
        }

    
    }
    
 


}
