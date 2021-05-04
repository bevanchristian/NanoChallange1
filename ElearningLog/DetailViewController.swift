//
//  DetailViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 27/04/21.
//

import UIKit
import CloudKit
import Alamofire
import AlamofireImage
protocol kirimNotif {
    func send()
}
class DetailViewController: UIViewController,UITextFieldDelegate, UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource, sendPoint, sendReview{
  
    
    @IBOutlet var editSkill: UIButton!
    
    @IBOutlet var editBelajar: UIButton!
    
    var data:Bool = false
    var namaUser:String = ""
    var maubelajarapaUser:String = ""
    var expertiseUser:String = ""
    var skillUser:String = ""
    var pointUser:String = ""
    var fotoUser = ""
    var home:ViewController!
    var urutan:IndexPath!
    var tipe = 0
    var id:CKRecord.ID!
    let elearn = elearnData()
    var detail = [detailModel]()
    var review = [reviewModel]()
    var cekIsiBelajar = false
    var cekIsiReview = false
    
    var counterSkill = 0
    var counterBelajar = 0
    @IBOutlet var ReviewCollectionView: UICollectionView!
    @IBOutlet var LearnCollectionView: UICollectionView!
    @IBOutlet var buttonSend: UIButton!
    
    let database = CKContainer(identifier: "iCloud.ElearningLog").publicCloudDatabase
    @IBOutlet var foto: UIImageView!
    @IBOutlet var point: UILabel!
    @IBOutlet var skill: UITextView!
    @IBOutlet var expertise: UILabel!
    @IBOutlet var maubelajarapa: UITextView!
    @IBOutlet var nama: UILabel!
    @IBOutlet var textskill: UITextView!
    var delegate2:kirimNotif!
    override func viewDidLoad() {
        super.viewDidLoad()
        skill.isEditable = false
        maubelajarapa.isEditable = false
        LearnCollectionView.delegate = self
        LearnCollectionView.dataSource = self
        
        ReviewCollectionView.delegate = self
        ReviewCollectionView.dataSource = self
       
        DispatchQueue.global(qos: .userInteractive
        ).async { [self] in
            manggilData(kedua: false)
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("detail"), object: nil, queue: OperationQueue.main) { [self] (notif) in
            let elearnVC = notif.object as?  elearnData
            print("masuk notif detail")
            detail = elearnVC!.detail
            review = elearnVC!.review
            print(detail)
            self.LearnCollectionView.reloadData()
            self.ReviewCollectionView.reloadData()
         
        }
        _ = ImageDownloader(
            configuration: ImageDownloader.defaultURLSessionConfiguration(),
            downloadPrioritization: .fifo,
            maximumActiveDownloads: 4,
            imageCache: AutoPurgingImageCache()
        )
        
        let downloader = ImageDownloader()
        let urlRequest = URLRequest(url: URL(string:fotoUser)!)

        downloader.download(urlRequest, completion:  { response in
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
            if case .success(let image) = response.result {
                self.foto.image = image
            }
        })

        foto.layer.cornerRadius = (foto.frame.size.width) / 2
        foto.clipsToBounds = true
        foto.layer.borderWidth = 2
       foto.layer.borderColor = UIColor.white.cgColor
        textskill.delegate = self
        navigationItem.largeTitleDisplayMode = .never
       // foto.image = fotoUser
        point.text = pointUser
        skill.text = skillUser
        expertise.text = expertiseUser
        maubelajarapa.text = maubelajarapaUser
        nama.text = namaUser

    
       
        
        // Do any additional setup after loading the view.
    }
    // ngisi point dari protocol
    func send(point: String) {
        self.point.text = point
        // aray ne design bodoh
        home.dataFixDesign[urutan.item].point = point
        
        if tipe == 1{
            print("a")
            home.dataFix[urutan.item].point = point
          
           
          
            
        }else if tipe == 2{
            print("ab")
            home.dataFixDesign[urutan.item].point = point
          
        }else{
            print("abc")
            home.dataFixPro[urutan.item].point = point
        
        }

        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: DispatchTime.now()+3) { [self] in
            data = true
            cekIsiBelajar = false
            manggilData(kedua: true)
        }
      
    }
    
    func sendReview() {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: DispatchTime.now()+3) { [self] in
            data = true
            cekIsiBelajar = false
            manggilData(kedua: true)
        }
    }
    
    
    func  manggilData(kedua:Bool){
        print("masuk detail")
        if data == true{
            elearn.detail.removeAll()
            elearn.review.removeAll()
            review.removeAll()
            detail.removeAll()
        }
        elearn.getDetail(nama: namaUser,kedua: kedua)
        elearn.getReview(nama: namaUser)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == LearnCollectionView{
            if detail.count > 0 {
                cekIsiBelajar = true
                return detail.count
    
            }else{
                
                return 1
            }
          
        }else{
            if review.count > 0{
                cekIsiReview = true
                return review.count
            }else{
                return 1
            }
         
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == LearnCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "learncell", for: indexPath) as! DetailWhatLearnCollectionViewCell
            if cekIsiBelajar{
                cell.label.text = detail[indexPath.row].nama_belajar
               // cell.foto.image = detail[indexPath.row].Foto
                let data = try? Data(contentsOf: (detail[indexPath.row].Foto?.fileURL)!)
                let image = UIImage(data: data!)
                cell.foto.image = image
                cell.foto.layer.cornerRadius = ( cell.foto.frame.size.width) / 4
                cell.foto.clipsToBounds = true
                cell.foto.layer.borderWidth = 2
                cell.foto.layer.borderColor = UIColor.white.cgColor
                
                
                cell.layer.shadowColor = UIColor.gray.cgColor
                cell.layer.shadowRadius = 1
                cell.layer.shadowOpacity = 0.25
                cell.layer.shadowOffset = CGSize(width: 0, height: 3.0)
                cell.clipsToBounds = false
                cell.layer.masksToBounds = false
                cell.layer.cornerRadius = 10
            }else{
                cell.label.text = "User belum belajar"
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewcell", for: indexPath) as! DetailReviewCollectionViewCell
            if cekIsiReview{
                cell.nama.text = review[indexPath.row].nama_review
                cell.reviewText.text = review[indexPath.row].review
            
                
            }else{
                cell.nama.text = "Uknown"
                cell.reviewText.text = "No review yet"
            }
            return cell
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == LearnCollectionView{
            let pindah = (storyboard?.instantiateViewController(identifier: "detailbelajar"))! as DetailBelajarViewController
            let data = try? Data(contentsOf: (detail[indexPath.row].Foto?.fileURL)!)
            let image = UIImage(data: data!)
            pindah.fotopindah = image
            pindah.deskrpsipindah = detail[indexPath.row].deskripsi
            pindah.judupindah = detail[indexPath.row].nama_belajar
            pindah.urlpindah = detail[indexPath.row].url
            
            navigationController?.pushViewController(pindah, animated: true)
        }
        
        
    }
    
    
    // UNTUK EDIT SKILL DAN BELAJAR
    
    @IBAction func belajarAction(_ sender: UIButton) {
        counterBelajar += 1
        if counterBelajar % 2 != 0{
            maubelajarapa.isEditable = true
            maubelajarapa.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            // jadi done image kosong
            editBelajar.setTitle("Done", for: .normal)
            editBelajar.setImage(nil, for: .normal)
           
           
      
        }else{
            maubelajarapa.layer.backgroundColor = nil
            maubelajarapa.isEditable = false
            editBelajar.setImage(UIImage(systemName: "pencil"), for: .normal)
            editBelajar.setTitle("", for: .normal)
        }
       
        
        
    }
    @IBAction func skillAction(_ sender: UIButton) {
        counterSkill += 1
        if counterSkill % 2 != 0{
            skill.isEditable = true
            skill.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            editSkill.setImage(UIImage(systemName: ""), for: .normal)
            editSkill.setTitle("Done", for: .normal)
      
        }else{
            skill.layer.backgroundColor = nil
            skill.isEditable = false
            editSkill.setImage(UIImage(systemName: "pencil"), for: .normal)
            editSkill.setTitle("", for: .normal)
        }
    }
    
    
    
    

    

 
    @IBAction func what_i_HaveLearn(_ sender: UIButton) {
        
        print("pindah")
        let pindah = (storyboard?.instantiateViewController(identifier: "learndetail"))! as BelajarViewController
        pindah.modalPresentationStyle = .pageSheet
        pindah.modalTransitionStyle = .coverVertical
        pindah.id = id
        pindah.nama = nama.text
        pindah.skor = point.text
        pindah.delegate = self
        navigationController?.present(pindah, animated: true)
    }
    
    @IBAction func reviewButton(_ sender: UIButton) {
        let pindah = (storyboard?.instantiateViewController(identifier: "review"))! as ReviewViewController
        pindah.modalPresentationStyle = .pageSheet
        pindah.modalTransitionStyle = .coverVertical
        pindah.id = id
        pindah.namauser = nama.text
        pindah.delegate = self
        navigationController?.present(pindah, animated: true)
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        simpanObjek()
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            saveProfil()
        }
     
        //delegate2.send()
      
    }
    
   
   
    
   
//SAVE KE CLOUDKIT
    func saveProfil(){

          
               
        let recordID = id
        database.fetch(withRecordID: recordID!) { [self] (record, error) in
                   
                   if error == nil {
                    DispatchQueue.main.async { [self] in
                       
                    record?.setValue(skill.text, forKey: "skill")
                   
                    record?.setValue(maubelajarapa.text, forKey: "mau_belajar")
                    }
                       self.database.save(record!, completionHandler: { (newRecord, error) in
                           
                           if error == nil {
                               //gabisa savee
                               print("Record Saved")
                               
                           } else {
                               
                               print("Record Not Saved")
                               
                           }
                           
                       })
                       
                   } else {
                       // ga ketemu record id
                       print("Could not fetch record")
                       
                   }
                   
               }
            
     
        
       
        
       
        
    }
    
    //SAVE KE BEJK
    func simpanObjek(){
        print("kesimpenobjek")
  
        if tipe == 1{
            home.dataFix[urutan.item].skill = skill.text
            home.dataFix[urutan.item].belajar = maubelajarapa.text
            print(skill.text)
            print(home.dataFix[urutan.item].skill)
           
          
            
        }else if tipe == 2{
            home.dataFixDesign[urutan.item].skill = skill.text
            home.dataFixDesign[urutan.item].belajar = maubelajarapa.text
        }else{
            home.dataFixPro[urutan.item].skill = skill.text
            home.dataFixPro[urutan.item].belajar = maubelajarapa.text

        }
    
    }
    
}
