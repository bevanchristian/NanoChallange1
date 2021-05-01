//
//  DetailViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 27/04/21.
//

import UIKit
import CloudKit

protocol kirimNotif {
    func send()
}
class DetailViewController: UIViewController,UITextFieldDelegate, UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource{
 
    
    var namaUser:String = ""
    var maubelajarapaUser:String = ""
    var expertiseUser:String = ""
    var skillUser:String = ""
    var pointUser:String = ""
    var fotoUser:UIImage!
    var home:ViewController!
    var urutan:IndexPath!
    var tipe = 0
    var id:CKRecord.ID!
    let elearn = elearnData()
    var detail = [detailModel]()
    var cekIsi = false
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
        LearnCollectionView.delegate = self
        LearnCollectionView.dataSource = self
        
        ReviewCollectionView.delegate = self
        ReviewCollectionView.dataSource = self

        NotificationCenter.default.addObserver(forName: NSNotification.Name("detail"), object: nil, queue: OperationQueue.main) { [self] (notif) in
            let elearnVC = notif.object as?  elearnData
            detail = elearnVC!.detail
            self.LearnCollectionView.reloadData()
         
        }
        performSelector(inBackground: #selector(manggilData), with: nil)
        
        textskill.delegate = self
        navigationItem.largeTitleDisplayMode = .never
        foto.image = fotoUser
        point.text = pointUser
        skill.text = skillUser
        expertise.text = expertiseUser
        maubelajarapa.text = maubelajarapaUser
        nama.text = namaUser

    
       
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func  manggilData(){
        elearn.getDetail(nama: namaUser)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == LearnCollectionView{
            if detail.count > 0{
                cekIsi = true
                return detail.count
    
            }else{
                return 1
            }
          
        }else{
            return 5
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == LearnCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "learncell", for: indexPath) as! DetailWhatLearnCollectionViewCell
            if cekIsi{
                cell.label.text = detail[indexPath.row].nama_belajar
               // cell.foto.image = detail[indexPath.row].Foto
                let data = try? Data(contentsOf: (detail[indexPath.row].Foto?.fileURL)!)
                let image = UIImage(data: data!)
                cell.foto.image = image
            }else{
                cell.label.text = "User belum belajar"
            }
      
    
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewcell", for: indexPath) as! DetailReviewCollectionViewCell
            
            return cell
        }
        
       
    }
    
    
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                           replacementString string: String) -> Bool
    {
        let maxLength = 4
        let currentString: NSString = textField.text as! NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

    

 
    @IBAction func what_i_HaveLearn(_ sender: UIButton) {
        
        print("pindah")
        let pindah = storyboard?.instantiateViewController(identifier: "learndetail")
        pindah?.modalPresentationStyle = .pageSheet
        pindah?.modalTransitionStyle = .coverVertical

        navigationController?.present(pindah!, animated: true)
    }
    @IBAction func buttonSendOutlet(_ sender: Any) {
        print("tex")
        //simpanObjek()
        //delegate2.send()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        simpanObjek()
        saveProfil()
        //delegate2.send()
      
    }
    
   
    @IBAction func reviewButton(_ sender: UIButton) {
        let pindah = storyboard?.instantiateViewController(identifier: "review")
        pindah?.modalPresentationStyle = .pageSheet
        pindah?.modalTransitionStyle = .coverVertical

        navigationController?.present(pindah!, animated: true)
    }
    
   
//SAVE KE CLOUDKIT
    func saveProfil(){
        DispatchQueue.main.async { [self] in
          
               
        let recordID = id
        database.fetch(withRecordID: recordID!) { [self] (record, error) in
                   
                   if error == nil {
                   
                       
                    record?.setValue(skill.text, forKey: "skill")
                    record?.setValue(maubelajarapa.text, forKey: "mau_belajar")
                       
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
