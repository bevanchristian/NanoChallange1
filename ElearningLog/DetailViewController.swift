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
class DetailViewController: UIViewController {
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

    @IBOutlet var buttonSend: UIButton!
    
    let database = CKContainer(identifier: "iCloud.ElearningLog").publicCloudDatabase
    @IBOutlet var foto: UIImageView!
    @IBOutlet var point: UILabel!
    @IBOutlet var skill: UITextView!
    @IBOutlet var expertise: UILabel!
    @IBOutlet var maubelajarapa: UITextView!
    @IBOutlet var nama: UILabel!
    var delegate2:kirimNotif!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        foto.image = fotoUser
        point.text = pointUser
        skill.text = skillUser
        expertise.text = expertiseUser
        maubelajarapa.text = maubelajarapaUser
        nama.text = namaUser

        // Do any additional setup after loading the view.
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
