//
//  WebResourceViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 05/05/21.
//

import UIKit
import WebKit

class WebResourceViewController: UIViewController,WKNavigationDelegate{

    var web = WKWebView()
    var urlpindah:String!
    override func loadView() {
        web.navigationDelegate = self
        view = web
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if verifyUrl(urlString: urlpindah){
            web.load(URLRequest(url: URL(string: urlpindah!)! ))
            web.allowsBackForwardNavigationGestures = true
        }else{
            web.load(URLRequest(url: URL(string: "https://appledeveloperacademy.uc.ac.id")! ))
            web.allowsBackForwardNavigationGestures = true
        }

 
        // Do any additional setup after loading the view.
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }


   
}
