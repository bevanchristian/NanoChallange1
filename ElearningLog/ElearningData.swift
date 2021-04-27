//
//  ElearningData.swift
//  ElearningLog
//
//  Created by bevan christian on 27/04/21.
//

import Foundation
import CloudKit
import UIKit
class elearnData{
    let nama = ""
    let photo = ""
    let expertise = ""
    let team = ""
    let shift = ""
    
    var nameArray = [String]()
    var photoArray = [String]()
    var mau_belajarArray = [String]()
    var pointArray = [String]()
    var skillArray = [String]()
    var expertiseArray = [String]()
    var shiftArray = [String]()
    var teamArray = [String]()
    
    var dataFix = [elearnModel]()
    
    let database = CKContainer(identifier: "iCloud.ElearningLog").publicCloudDatabase
    
    
    
    func GetData(myview:ViewController){
        
        let query = CKQuery(recordType: "User", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { [self] (records, error) in
            // jika record nya nill maka manggil dari api
            if records != nil {
        
            // diterima dari cloudkit masih dalam bentuk array
                nameArray = records!.compactMap({$0.value(forKey:"nama") as? String})
                photoArray = records!.compactMap({ $0.value(forKey: "foto") as? String})
                mau_belajarArray = records!.compactMap({$0.value(forKey:"mau_belajar") as? String})
                pointArray = records!.compactMap({ $0.value(forKey: "point") as? String})
                skillArray = records!.compactMap({ $0.value(forKey: "skill") as? String})
                expertiseArray = records!.compactMap({$0.value(forKey:"expertise") as? String})
                shiftArray = records!.compactMap({ $0.value(forKey: "shift") as? String})
                teamArray = records!.compactMap({$0.value(forKey:"team") as? String})
                
                
                for x in 0...nameArray.count-1{
                    var model = elearnModel()
                    model.nama = nameArray[x]
                    print(photoArray[x])
                    if photoArray[x] != nil{
                        if let datafoto = try? Data(contentsOf: (URL(string: photoArray[x]) ?? URL(string: "https://dl.airtable.com/.attachments/793d85215a4c8118e5c815854d5b3725/0ceb3359/FelindaGracia.jpg"))! ) {
                            if let foto = UIImage(data: datafoto) {
                                model.photo = foto
                            }
                        }
                    }
                 
                  
                    model.expertise = expertiseArray[x]
                    model.team = teamArray[x]
                    model.shift = shiftArray[x]
                    model.belajar = mau_belajarArray[x]
                    model.point = pointArray[x]
                    model.skill = skillArray[x]
                    dataFix.append(model)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "API"), object: self)
                }
               
            
        }else{
            // jika cloud ga ada manggil api dan dia nanti nyimpen kedalam cloud
            let urlString = "https://nc2.theideacompass.com/explorers-api.json"
            if let url = try? URL(string: urlString){
                URLSession.shared.dataTask(with: url) { [self] data, response, error in
                  if let data = data {
                    parse(data)
                    // function closure
                  }
               }.resume()
                
            }
            
        }
        
        
    }
    
  
       

    
    func parse(_ json:Data){
        let decoder = JSONDecoder()
        if let jsonDecoder = try? decoder.decode([dataExplor].self, from: json){
        
            for x in 0...jsonDecoder.count-1{
                var model = elearnModel()
                model.nama = jsonDecoder[x].Name
                
                if photoArray[x] != nil{
                    if let datafoto = try? Data(contentsOf: (URL(string: jsonDecoder[x].Photo) ?? URL(string: "https://dl.airtable.com/.attachments/793d85215a4c8118e5c815854d5b3725/0ceb3359/FelindaGracia.jpg"))! ) {
                        if let foto = UIImage(data: datafoto) {
                            model.photo = foto
                        }
                    }
                }
                model.expertise = jsonDecoder[x].Expertise
                model.team = jsonDecoder[x].Team
                model.shift = jsonDecoder[x].Shift
                model.belajar = "-"
                model.point = "0"
                model.skill = "-"
                
                dataFix.append(model)
           
                
                
                // nyimpen ke cloud
                saveProfil(name: model.nama, foto: model.photo!, belajar: model.belajar, point: model.point, skill: model.skill, expertise: model.expertise, shift: model.shift, team: model.team)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "API"), object: self)
            }
           
            
        }
        
    }
    
    func saveProfil(name:String,foto:UIImage,belajar:String,point:String,skill:String,expertise:String,shift:String,team:String){
        let record = CKRecord(recordType: "User")
        record.setValue(name, forKey: "nama")
        record.setValue(foto, forKey: "foto")
        record.setValue(belajar, forKey: "mau_belajar")
        record.setValue(point, forKey: "point")
        record.setValue(skill, forKey: "skill")
        record.setValue(expertise, forKey: "expertise")
        record.setValue(shift, forKey: "shift")
        record.setValue(team, forKey: "team")
            
            

        database.save(record) { (record, error) in
            if record != nil , error == nil{
                print("saved")
            }else{
                print(error)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
}
