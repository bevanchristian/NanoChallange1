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
    
    
    
    var nameArrayDesign = [String]()
    var photoArrayDesign = [String]()
    var mau_belajarArrayDesign = [String]()
    var pointArrayDesign = [String]()
    var skillArrayDesign = [String]()
    var expertiseArrayDesign = [String]()
    var shiftArrayDesign = [String]()
    var teamArrayDesign = [String]()
    
    var dataFix = [elearnModel]()
    var dataFixDesign = [elearnModel]()
    
    let database = CKContainer(identifier: "iCloud.ElearningLog").publicCloudDatabase
    
    
    
    func GetData(myview:ViewController){
        // it
        let predicate = NSPredicate(format: "expertise == %@", "Tech / IT / IS")
        let query = CKQuery(recordType: "User", predicate: predicate)
        database.perform(query, inZoneWith: nil) { [self] (records, error) in
            // jika record nya nill maka manggil dari api
            if records != nil {
        print("asi")
            // diterima dari cloudkit masih dalam bentuk array
                print(records)
                nameArray = records!.compactMap({$0.value(forKey:"nama") as? String})
                photoArray = records!.compactMap({ $0.value(forKey: "foto") as? String})
                mau_belajarArray = records!.compactMap({$0.value(forKey:"mau_belajar") as? String})
                pointArray = records!.compactMap({ $0.value(forKey: "point") as? String})
                skillArray = records!.compactMap({ $0.value(forKey: "skill") as? String})
                expertiseArray = records!.compactMap({$0.value(forKey:"expertise") as? String})
                shiftArray = records!.compactMap({ $0.value(forKey: "shift") as? String})
                teamArray = records!.compactMap({$0.value(forKey:"team") as? String})
                
                
                if nameArray.count > 0{

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
                    print("kosong")
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
        
        
    // design ===================================================== area design dibawah ini ========= untuk home
        
        
        
        
        let predicateDesign = NSPredicate(format: "expertise == %@", "Design")
        let queryDesign = CKQuery(recordType: "User", predicate: predicateDesign)
        database.perform(queryDesign, inZoneWith: nil) { [self] (records, error) in
            // jika record nya nill maka manggil dari api
            if records != nil {
        print("asi")
            // diterima dari cloudkit masih dalam bentuk array
       
                print(records)
                nameArrayDesign = records!.compactMap({$0.value(forKey:"nama") as? String})
                photoArrayDesign = records!.compactMap({ $0.value(forKey: "foto") as? String})
                mau_belajarArrayDesign = records!.compactMap({$0.value(forKey:"mau_belajar") as? String})
                pointArrayDesign = records!.compactMap({ $0.value(forKey: "point") as? String})
                skillArrayDesign = records!.compactMap({ $0.value(forKey: "skill") as? String})
                expertiseArrayDesign = records!.compactMap({$0.value(forKey:"expertise") as? String})
                shiftArrayDesign = records!.compactMap({ $0.value(forKey: "shift") as? String})
                teamArrayDesign = records!.compactMap({$0.value(forKey:"team") as? String})
                
                
                if nameArray.count > 0{

                for x in 0...nameArrayDesign.count-1{
                    var model = elearnModel()
                    model.nama = nameArrayDesign[x]
       
                    if photoArrayDesign[x] != nil{
                        if let datafoto = try? Data(contentsOf: (URL(string: photoArrayDesign[x]) ?? URL(string: "https://dl.airtable.com/.attachments/793d85215a4c8118e5c815854d5b3725/0ceb3359/FelindaGracia.jpg"))! ) {
                            if let foto = UIImage(data: datafoto) {
                                model.photo = foto
                            }
                        }
                    }
                    model.expertise = expertiseArrayDesign[x]
                    model.team = teamArrayDesign[x]
                    model.shift = shiftArrayDesign[x]
                    model.belajar = mau_belajarArrayDesign[x]
                    model.point = pointArrayDesign[x]
                    model.skill = skillArrayDesign[x]
                    dataFixDesign.append(model)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "API"), object: self)
                }
                }else{
                    print("kosong")
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
        
    

    
  }// ahkir dari get data
    
    func removeArray(){
        nameArray.removeAll()
        photoArray.removeAll()
        mau_belajarArray.removeAll()
        pointArray.removeAll()
        skillArray.removeAll()
        expertiseArray.removeAll()
        shiftArray.removeAll()
        teamArray.removeAll()
        
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
