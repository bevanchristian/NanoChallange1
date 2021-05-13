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
        navigationController?.navigationBar.isTranslucent = false
        if verifyUrl(urlString: urlpindah){
            webView.load(URLRequest(url: URL(string: urlpindah!)! ))
            webView.allowsBackForwardNavigationGestures = true
        }else{
            webView.load(URLRequest(url: URL(string: "https://appledeveloperacademy.uc.ac.id")! ))
            webView.allowsBackForwardNavigationGestures = true
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
