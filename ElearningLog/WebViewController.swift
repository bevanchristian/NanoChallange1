//
//  WebViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 02/05/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKNavigationDelegate {

    var urlpindah:String?
    var webView:WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = try? URL(string: urlpindah ?? "https://appledeveloperacademy.uc.ac.id") {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
            //pr kalo web e ga valid
        }
       
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
