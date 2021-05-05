//
//  DetailBelajarViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 02/05/21.
//

import UIKit

class DetailBelajarViewController: UIViewController {

    @IBOutlet var buttonPindah: UIButton!
    var fotopindah:UIImage!
    var judupindah:String!
    var urlpindah:String!
    var deskrpsipindah:String!
    @IBOutlet var deskripsi: UILabel!
   
    @IBOutlet var judul: UILabel!
    @IBOutlet var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonPindah.layer.shadowColor = UIColor.gray.cgColor
        buttonPindah.layer.shadowRadius = 4
        buttonPindah.layer.shadowOpacity = 0.25
        buttonPindah.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        buttonPindah.clipsToBounds = false
        buttonPindah.layer.masksToBounds = false
        buttonPindah.layer.cornerRadius = 6

        image.image = fotopindah
        judul.text = judupindah
        deskripsi.text = deskrpsipindah
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
           navigationController?.navigationBar.shadowImage = UIImage()
           navigationController?.navigationBar.isTranslucent = true

        buttonPindah.layer.cornerRadius = 10.0
        // Do any additional setup after loading the view.
    }
    

    @IBAction func url(_ sender: UIButton) {
        let pindah = (storyboard?.instantiateViewController(identifier: "webdetail"))! as WebViewController
        pindah.urlpindah = urlpindah
        navigationController?.pushViewController(pindah, animated: true)
    }
  

}
