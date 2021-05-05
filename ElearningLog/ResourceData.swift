//
//  ResourceData.swift
//  ElearningLog
//
//  Created by bevan christian on 05/05/21.
//

import Foundation


class ResourceData {
    var resourceArray = [resourceDataModel]()
    
    func getResource(){
        let urlString = "https://api.airtable.com/v0/appHNqX9Y6OlWc5pl/Academy%20Activities?api_key=keyEw86jNVISZ5Xny"
        if let url = try? URL(string: urlString){
            URLSession.shared.dataTask(with: url) { [self] data, response, error in
              if let data = data {
                print("anjing")
                parse(data)
              
              }
           }.resume()
            
        }
    }
    
    
    
    func parse(_ json:Data){
        let decoder = JSONDecoder()
        if let jsonDecoder = try? decoder.decode(resourcemodel.self, from: json){
        
            for x in 0...jsonDecoder.records.count-1{
                
                if jsonDecoder.records[x].fields.ResourcesLink != nil{
                    var resource = resourceDataModel()
                    resource.link = jsonDecoder.records[x].fields.ResourcesLink
                    resource.namaResource = jsonDecoder.records[x].fields.ActivityResourceName
                    resourceArray.append(resource)
                }
            
            }
                
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resource"), object: self)
           
           
            
        }
        
    }
   
}



