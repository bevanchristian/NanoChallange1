//
//  ResourceViewController.swift
//  ElearningLog
//
//  Created by bevan christian on 05/05/21.
//

import UIKit

class ResourceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    

 
    @IBOutlet var tableView: UITableView!
    var data = ResourceData()
    var resourceArray = [resourceDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Academy Resource"
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            data.getResource()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("resource"), object: nil, queue: OperationQueue.main) { [self] (notif) in
            let resVC = notif.object as! ResourceData
            resourceArray = resVC.resourceArray
            tableView.reloadData()
        }
      
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resourceCell", for: indexPath) as! ResourceTableViewCell
        cell.title.text = resourceArray[indexPath.row].namaResource
        cell.subs.text = resourceArray[indexPath.row].link
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pindah = storyboard?.instantiateViewController(identifier: "webResource") as! WebResourceViewController
        //var bersihLink = resourceArray[indexPath.row].link.replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\n\n", with: "").replacingOccurrences(of: "- Numbers:", with: "").replacingOccurrences(of: <#T##StringProtocol#>, with: <#T##StringProtocol#>)
       
            
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: resourceArray[indexPath.row].link, options: [], range: NSRange(location: 0, length: resourceArray[indexPath.row].link.utf16.count))

        for match in matches {
            guard let range = Range(match.range, in: resourceArray[indexPath.row].link) else { continue }
            let url = resourceArray[indexPath.row].link[range]
            print(url)
            pindah.urlpindah = String(url)
        }

        navigationController?.pushViewController(pindah, animated: true)
    }

   

}
