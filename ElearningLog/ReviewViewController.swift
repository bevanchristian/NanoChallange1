//
//  ReviewViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 02/05/21.
//

import UIKit
import CloudKit
protocol sendReview {
    func sendReview()
}

class ReviewViewController: UIViewController {

    @IBOutlet var review: UITextView!
    
    @IBOutlet var nama: UITextField!
    let database = CKContainer(identifier: "iCloud.ElearningLog").publicCloudDatabase
    var id:CKRecord.ID!
    var namauser:String!
    var delegate:sendReview?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Review"
 

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        saveProfil(nama: namauser, nama_review: nama.text!, review: review.text)
        delegate!.sendReview()
        dismiss(animated: true)
       
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    func saveProfil(nama:String,nama_review:String,review:String){
        let record = CKRecord(recordType: "review")
        
        record.setValue(nama, forKey: "nama")
        record.setValue(nama_review, forKey: "nama_review")
        record.setValue(review, forKey: "review")
      

    
       
            

        database.save(record) { (record, error) in
            
            if record != nil , error == nil{
                print("saved")
            }else{
                print(error)
            }
        }
    }

}
