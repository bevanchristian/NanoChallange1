//
//  BelajarViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 01/05/21.
//

import UIKit
import CloudKit

protocol sendPoint {
    func send(point:String)
}


class BelajarViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    
    @IBOutlet var judul: UITextField!
    @IBOutlet var deskripsi: UITextView!
    @IBOutlet var url: UITextField!
    let database = CKContainer(identifier: "iCloud.ElearningLog").publicCloudDatabase
    var id:CKRecord.ID!
    var nama:String!
    var imageUpload:CKAsset!
    var skor:String!
    @IBOutlet var image: UIButton!
    var delegate:sendPoint!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        image.setTitle("Upload A Photo", for: .normal)


   
        // Do any additional setup after loading the view.
    }
    

    //add button
    @IBAction func add(_ sender: UIButton) {
   
        if var skorSementara = try? Int(skor){
            skorSementara += 100
            delegate.send(point: String(skorSementara))
            saveProfilPoint(point: String(skorSementara))
        }
        
        
        saveProfil(nama:nama,judul: judul.text!, deskripsi: deskripsi.text, url: url.text!, foto: imageUpload)
        dismiss(animated: true)
    }
    @IBAction func upload(_ sender: Any) {
        let picker = UIImagePickerController()
        // supaya bisa dipencet
        picker.delegate = self
        //supaya bisa croping
        picker.allowsEditing = true
        // present
        present(picker, animated: true, completion: nil)
    
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //setelah dipencet galery ne km ambil masukan ke image
        guard let image = info[.editedImage] as? UIImage else { return }
    
        self.image.setBackgroundImage(image, for: .normal)
        self.image.setBackgroundImage(image, for: .disabled)
        self.image.contentMode = .scaleAspectFit
        self.image.titleLabel?.text = ""
        self.image.isEnabled = false
        
        


 
        // ubah image (jpg) jadi ckasset biar bisa di save
        if let jpgData = image.jpegData(compressionQuality: 0.8){
           
            let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
            do {
                try jpgData.write(to: url!)
                print("sukses ckasset")
            } catch let e as NSError {
                print("Error! \(e)");
                return
            }
            imageUpload = CKAsset(fileURL: url!)
        }
   
        dismiss(animated: true, completion: nil)
    
    }
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    
    //save ke cloudkit
    func saveProfil(nama:String,judul:String,deskripsi:String,url:String,foto:CKAsset){
        let record = CKRecord(recordType: "Belajar")
        
        record.setValue(nama, forKey: "nama")
        record.setValue(judul, forKey: "nama_belajar")
        record.setValue(foto, forKey: "Foto")
        record.setValue(deskripsi, forKey: "deskripsi")
        record.setValue(url, forKey: "url")

    
       
            

        database.save(record) { (record, error) in
            
            if record != nil , error == nil{
                print("saved")
            }else{
                print(error)
            }
        }
    }
    
    
    // update point
    func saveProfilPoint(point:String){
        DispatchQueue.main.async { [self] in
          
               
        let recordID = id
        database.fetch(withRecordID: recordID!) { [self] (record, error) in
                   
                   if error == nil {
                   
                       
                    record?.setValue(point, forKey: "point")
              
                       
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
    
    

}
