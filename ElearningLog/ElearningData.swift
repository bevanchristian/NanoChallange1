//
//  ElearningData.swift
//  ElearningLog
//
//  Created by bevan christian on 27/04/21.
//

import Foundation
import CloudKit
import UIKit
import Alamofire
import AlamofireImage
class elearnData{
    let nama = ""
    let photo = ""
    let expertise = ""
    let team = ""
    let shift = ""
    
    
    var idArray = [String]()
    var nameArray = [String]()
    var photoArray = [String]()
    var mau_belajarArray = [String]()
    var pointArray = [String]()
    var skillArray = [String]()
    var expertiseArray = [String]()
    var shiftArray = [String]()
    var teamArray = [String]()
    
    
    var idDesingArray = [String]()
    var nameArrayDesign = [String]()
    var photoArrayDesign = [String]()
    var mau_belajarArrayDesign = [String]()
    var pointArrayDesign = [String]()
    var skillArrayDesign = [String]()
    var expertiseArrayDesign = [String]()
    var shiftArrayDesign = [String]()
    var teamArrayDesign = [String]()
    
    
    var idProArray = [String]()
    var nameArrayPro = [String]()
    var photoArrayPro = [String]()
    var mau_belajarArrayPro = [String]()
    var pointArrayPro = [String]()
    var skillArrayPro = [String]()
    var expertiseArrayPro = [String]()
    var shiftArrayPro = [String]()
    var teamArrayPro = [String]()
    
    
    // array penyimpan model
    var dataFix = [elearnModel]()
    var dataFixDesign = [elearnModel]()
    var dataFixPro = [elearnModel]()
    var detail = [detailModel]()
    var review = [reviewModel]()
    
    
    var recordIdit = [CKRecord.ID]()
    var recordIdDesign = [CKRecord.ID]()
    var recordIdPro = [CKRecord.ID]()
    
    let database = CKContainer(identifier: "iCloud.ElearningLog").publicCloudDatabase
    
    func removeArray(){
        nameArray.removeAll()
        photoArray.removeAll()
        mau_belajarArray.removeAll()
        pointArray.removeAll()
        skillArray.removeAll()
        expertiseArray.removeAll()
        shiftArray.removeAll()
        teamArray.removeAll()
        
        nameArrayPro.removeAll()
        photoArrayPro.removeAll()
        mau_belajarArrayPro.removeAll()
        pointArrayPro.removeAll()
        skillArrayPro.removeAll()
        expertiseArrayPro.removeAll()
        shiftArrayPro.removeAll()
        teamArrayPro.removeAll()
        
        nameArrayDesign.removeAll()
        photoArrayDesign.removeAll()
        mau_belajarArrayDesign.removeAll()
        pointArrayDesign.removeAll()
        skillArrayDesign.removeAll()
        expertiseArrayDesign.removeAll()
        shiftArrayDesign.removeAll()
        teamArrayDesign.removeAll()
        
    }
    
    func it(leaderboard:Bool){
        removeArray()
        let predicate = NSPredicate(format: "expertise == %@", "Tech / IT / IS")
        
        let query = CKQuery(recordType: "User", predicate: predicate)
        if leaderboard{
            print("leaderboard it")
            query.sortDescriptors = [NSSortDescriptor(key: "point", ascending: false)]
        }
        // ini dapetin record idnya
        let operation = CKQueryOperation(query: query)
        if leaderboard{
            operation.resultsLimit = 20
        }
        operation.qualityOfService = .userInteractive
        operation.recordFetchedBlock = { [self] (record) in
            print("query anyar")
            print("it")
            print(record.recordID)
            print(record["nama"]!)
            print(record["expertise"]!)
           /* recordIdit.append(record.recordID)
            nameArray.append((record["nama"] as? String)!)
            photoArray.append((record["foto"] as? String)!)
            mau_belajarArray.append((record["mau_belajar"] as? String)!)
            pointArray.append((record["point"] as? String)!)
            skillArray.append((record["skill"] as? String)!)
            expertiseArray.append((record["expertise"] as? String)!)
            shiftArray.append((record["shift"] as? String)!)
            teamArray.append((record["team"] as? String)!)*/
            
            var model = elearnModel()

            model.nama = (record["nama"] as? String)!
            model.id = record.recordID
            model.expertise = (record["expertise"] as? String)!
            model.team = (record["team"] as? String)!
            model.shift = (record["shift"] as? String)!
            model.belajar = (record["mau_belajar"] as? String)!
            model.point = (record["point"] as? String)!
            model.skill = (record["skill"] as? String)!
            model.photo = (record["foto"] as? String)!
            
            
        
            print("foto \(model.photo)")
            dataFix.append(model)
            //print(photoArray[x])
         /*   if (record["foto"] as? String)! != nil{
                if let datafoto = try? Data(contentsOf: (URL(string: (record["foto"] as? String)!) ?? URL(string: "https://dl.airtable.com/.attachments/793d85215a4c8118e5c815854d5b3725/0ceb3359/FelindaGracia.jpg"))! ) {
                    if let foto = UIImage(data: datafoto) {
                        model.photo = foto
                    }
                }
            }*/
            //let recordID = CKRecord.ID(recordName: model.nama)
           
            
        }
        
        operation.queryCompletionBlock = { [self] cursor ,error in
                print("RecordIDs it: \(recordIdit)")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "API"), object: self)
            if recordIdit.count != nil {
       
                print("ada")
            
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
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "API"), object: self)
        }
        
        database.add(operation)
    }
    func design(leaderboard:Bool){
        removeArray()
        let predicateDesign = NSPredicate(format: "expertise == %@", "Design")
        let queryDesign = CKQuery(recordType: "User", predicate: predicateDesign)
        if leaderboard{
            queryDesign.sortDescriptors = [NSSortDescriptor(key: "point", ascending: false)]
        }
        
        // ini dapetin record idnya
        let operationdesign = CKQueryOperation(query: queryDesign)
        
        if leaderboard{
            operationdesign.resultsLimit = 20
        }
        operationdesign.qualityOfService = .userInteractive
        operationdesign.recordFetchedBlock = { [self] (record) in
            print("query anyar")
            
            print(record.recordID)
            print(record["nama"]!)
            print(record["expertise"]!)
            recordIdDesign.append(record.recordID)
            
            var model = elearnModel()
            model.id = record.recordID
            model.nama = (record["nama"] as? String)!
            model.expertise = (record["expertise"] as? String)!
            model.team = (record["team"] as? String)!
            model.shift = (record["shift"] as? String)!
            model.belajar = (record["mau_belajar"] as? String)!
            model.point = (record["point"] as? String)!
            model.skill = (record["skill"] as? String)!
            model.photo = (record["foto"] as? String)!
            print("foto \(model.photo)")
            dataFixDesign.append(model)
        }
        
        operationdesign.queryCompletionBlock = { cursor ,error in
            
            DispatchQueue.main.async { [self] in
                         
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "API"), object: self)
                if recordIdDesign.count != nil {
           
                    print("ada")}else{
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
            
        }
        
        database.add(operationdesign)
    }
    
    func pro(leaderboard:Bool){
        removeArray()
        let predicatePro = NSPredicate(format: "expertise == %@", "Domain Expert (Keahlian Khusus)")
        let queryPro = CKQuery(recordType: "User", predicate: predicatePro)
        if leaderboard{
            queryPro.sortDescriptors = [NSSortDescriptor(key: "point", ascending: false)]
        }
        // ini dapetin record idnya
        let operationpro = CKQueryOperation(query: queryPro)
        
        if leaderboard{
            operationpro.resultsLimit = 20
        }
        operationpro.qualityOfService = .userInteractive
        operationpro.recordFetchedBlock = { [self] (record) in
            print("query anyar")
            
            print(record.recordID)
            print(record["nama"]!)
            print(record["expertise"]!)
            recordIdPro.append(record.recordID)
            
            
            var model = elearnModel()
            model.id = record.recordID
            model.nama = (record["nama"] as? String)!
            model.expertise = (record["expertise"] as? String)!
            model.team = (record["team"] as? String)!
            model.shift = (record["shift"] as? String)!
            model.belajar = (record["mau_belajar"] as? String)!
            model.point = (record["point"] as? String)!
            model.skill = (record["skill"] as? String)!
            model.photo = (record["foto"] as? String)!
            print("foto \(model.photo)")
            dataFixPro.append(model)
        }
        
        operationpro.queryCompletionBlock = { cursor ,error in
            
            DispatchQueue.main.async { [self] in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "API"), object: self)
                if recordIdDesign.count != nil {
                    
                    print("ada")}else{
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
            
        }
        
        database.add(operationpro)
    }
    
    func GetData(myview:ViewController){
        
        
        it(leaderboard: false)
        design(leaderboard: false)
        pro(leaderboard: false)
        
        
        removeArray()
        // it
       /* let predicate = NSPredicate(format: "expertise == %@", "Tech / IT / IS")
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        // ini dapetin record idnya
        let operation = CKQueryOperation(query: query)
        operation.recordFetchedBlock = { [self] (record) in
            print("query anyar")
            print("it")
            print(record.recordID)
            print(record["nama"]!)
            print(record["expertise"]!)
            recordIdit.append(record.recordID)
        }
        
        operation.queryCompletionBlock = { [self] cursor ,error in
            
                  
                print("RecordIDs it: \(recordIdit)")
            
            
            
                         
                   
            
        }
        
        database.add(operation)*/
        
     /*  database.perform(query, inZoneWith: nil) { [self] (records, error) in
            // jika record nya nill maka manggil dari api
            if records != nil {
        print("asi")
            // diterima dari cloudkit masih dalam bentuk array
              
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
                    //let recordID = CKRecord.ID(recordName: model.nama)
                    model.id = recordIdit[x]
                    model.expertise = expertiseArray[x]
                    model.team = teamArray[x]
                    model.shift = shiftArray[x]
                    model.belajar = mau_belajarArray[x]
                    model.point = pointArray[x]
                    model.skill = skillArray[x]
                    dataFix.append(model)
                    //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "API"), object: self)
                }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "API"), object: self)
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
        
        
    } */// database peform
        
        
    // design ===================================================== area design dibawah ini ========= untuk home
        
        
        
        
      /*  let predicateDesign = NSPredicate(format: "expertise == %@", "Design")
        let queryDesign = CKQuery(recordType: "User", predicate: predicateDesign)
        
        
        // ini dapetin record idnya
        let operationdesign = CKQueryOperation(query: queryDesign)
        operation.recordFetchedBlock = { [self] (record) in
            print("query anyar")
            
            print(record.recordID)
            print(record["nama"]!)
            print(record["expertise"]!)
            recordIdDesign.append(record.recordID)
        }
        
        operationdesign.queryCompletionBlock = { cursor ,error in
            
            DispatchQueue.main.async { [self] in
                         
                  
                         print("RecordIDs design: \(recordIdDesign)")
                         
                     }
            
        }
        
        database.add(operationdesign)*/
       /* database.perform(queryDesign, inZoneWith: nil) { [self] (records, error) in
            // jika record nya nill maka manggil dari api
            if records != nil {
        print("asi")
            // diterima dari cloudkit masih dalam bentuk array
       
         
               
              
                
               
                nameArrayDesign = records!.compactMap({$0.value(forKey:"nama") as? String})
                photoArrayDesign = records!.compactMap({ $0.value(forKey: "foto") as? String})
                mau_belajarArrayDesign = records!.compactMap({$0.value(forKey:"mau_belajar") as? String})
                pointArrayDesign = records!.compactMap({ $0.value(forKey: "point") as? String})
                skillArrayDesign = records!.compactMap({ $0.value(forKey: "skill") as? String})
                expertiseArrayDesign = records!.compactMap({$0.value(forKey:"expertise") as? String})
                shiftArrayDesign = records!.compactMap({ $0.value(forKey: "shift") as? String})
                teamArrayDesign = records!.compactMap({$0.value(forKey:"team") as? String})
                
                
                if nameArrayDesign.count > 0{

                for x in 0...nameArrayDesign.count-1{
                    var model = elearnModel()
                    model.nama = nameArrayDesign[x]
       
                    print("design")
                    if photoArrayDesign[x] != nil{
                        if let datafoto = try? Data(contentsOf: (URL(string: photoArrayDesign[x]) ?? URL(string: "https://dl.airtable.com/.attachments/793d85215a4c8118e5c815854d5b3725/0ceb3359/FelindaGracia.jpg"))! ) {
                            if let foto = UIImage(data: datafoto) {
                                model.photo = foto
                            }
                        }
                    }
            
                    model.id = recordIdDesign[x]
                    model.expertise = expertiseArrayDesign[x]
                    model.team = teamArrayDesign[x]
                    model.shift = shiftArrayDesign[x]
                    model.belajar = mau_belajarArrayDesign[x]
                    model.point = pointArrayDesign[x]
                    model.skill = skillArrayDesign[x]
                    dataFixDesign.append(model)
                    //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "API"), object: self)
                }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "API"), object: self)
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
        
        
    }*/
        
        // profesional ===================================================== area prodesional dibawah ini ========= untuk home
    
        
      /*  let predicatePro = NSPredicate(format: "expertise == %@", "Domain Expert (Keahlian Khusus)")
        let queryPro = CKQuery(recordType: "User", predicate: predicatePro)
        
        // ini dapetin record idnya
        let operationpro = CKQueryOperation(query: queryPro)
        operationpro.recordFetchedBlock = { [self] (record) in
            print("query anyar")
            
            print(record.recordID)
            print(record["nama"]!)
            print(record["expertise"]!)
            recordIdPro.append(record.recordID)
        }
        
        operationpro.queryCompletionBlock = { cursor ,error in
            
            DispatchQueue.main.async { [self] in
                         
                  
                         print("RecordIDs pro: \(recordIdPro)")
                         
                     }
            
        }
        
        database.add(operationpro)*/
      /*  database.perform(queryPro, inZoneWith: nil) { [self] (records, error) in
            // jika record nya nill maka manggil dari api
            if records != nil {
        print("asi")
            // diterima dari cloudkit masih dalam bentuk array
       
               
                nameArrayPro = records!.compactMap({$0.value(forKey:"nama") as? String})
                photoArrayPro = records!.compactMap({ $0.value(forKey: "foto") as? String})
                mau_belajarArrayPro = records!.compactMap({$0.value(forKey:"mau_belajar") as? String})
                pointArrayPro = records!.compactMap({ $0.value(forKey: "point") as? String})
                skillArrayPro = records!.compactMap({ $0.value(forKey: "skill") as? String})
                expertiseArrayPro = records!.compactMap({$0.value(forKey:"expertise") as? String})
                shiftArrayPro = records!.compactMap({ $0.value(forKey: "shift") as? String})
                teamArrayPro = records!.compactMap({$0.value(forKey:"team") as? String})
                
                
                if nameArrayPro.count > 0{

                for x in 0...nameArrayPro.count-1{
                    var model = elearnModel()
                    model.nama = nameArrayPro[x]
       
                    print("design")
                    if photoArrayPro[x] != nil{
                        if let datafoto = try? Data(contentsOf: (URL(string: photoArrayPro[x]) ?? URL(string: "https://dl.airtable.com/.attachments/793d85215a4c8118e5c815854d5b3725/0ceb3359/FelindaGracia.jpg"))! ) {
                            if let foto = UIImage(data: datafoto) {
                                model.photo = foto
                            }
                        }
                    }
                    //let recordID = CKRecord.ID(recordName: model.nama)
                    model.id = recordIdPro[x]
                    model.expertise = expertiseArrayPro[x]
                    model.team = teamArrayPro[x]
                    model.shift = shiftArrayPro[x]
                    model.belajar = mau_belajarArrayPro[x]
                    model.point = pointArrayPro[x]
                    model.skill = skillArrayPro[x]
                    dataFixPro.append(model)
                    //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "API"), object: self)
                }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "API"), object: self)
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
        
        
    }*/

    
  }// ahkir dari get data
    
   
    func getDetail(nama:String,kedua:Bool){
        
        
      
        
        let predicateDetail = NSPredicate(format: "nama == %@", "\(nama)")
        let queryDetail = CKQuery(recordType: "Belajar", predicate: predicateDetail)
        
        // ini dapetin record idnya
        let operationDetail = CKQueryOperation(query: queryDetail)
       // operationDetail.qualityOfService = .userInteractive
        operationDetail.recordFetchedBlock = { [self] (record) in
            
            
            
            var modelDetail = detailModel()
        
            modelDetail.nama = (record["nama"] as? String)!
            modelDetail.nama_belajar = (record["nama_belajar"] as? String)!
            modelDetail.Foto = (record["Foto"] as? CKAsset)!
            modelDetail.deskripsi = (record["deskripsi"] as? String)!
            modelDetail.url = (record["url"] as? String)!
            detail.append(modelDetail)
            
          
        }
        
        operationDetail.queryCompletionBlock = { cursor ,error in
            NotificationCenter.default.post(name: NSNotification.Name("detail"), object: self)
 
        }
        
        database.add(operationDetail)
    }
    
    
    func getReview(nama:String){
        
        let predicateReview = NSPredicate(format: "nama == %@", "\(nama)")
        let queryReview = CKQuery(recordType: "review", predicate: predicateReview)
        
        // ini dapetin record idnya
        let operationReview = CKQueryOperation(query: queryReview)
        //operationReview.qualityOfService = .userInteractive
        operationReview.recordFetchedBlock = { [self] (record) in
            
            
            
            var modelReview = reviewModel()
        
            modelReview.nama = (record["nama"] as? String)!
            modelReview.nama_review = (record["nama_review"] as? String)!
            modelReview.review = (record["review"] as? String)!
          
            review.append(modelReview)
            
          
        }
        
        operationReview.queryCompletionBlock = { cursor ,error in
            NotificationCenter.default.post(name: NSNotification.Name("detail"), object: self)
 
        }
        
        database.add(operationReview)
    }
    
    
    
    
    
    func parse(_ json:Data){
        let decoder = JSONDecoder()
        if let jsonDecoder = try? decoder.decode([dataExplor].self, from: json){
        
            for x in 0...jsonDecoder.count-1{
                var model = elearnModel()
                model.nama = jsonDecoder[x].Name
                
              
                model.photo = jsonDecoder[x].Photo
                model.expertise = jsonDecoder[x].Expertise
                model.team = jsonDecoder[x].Team
                model.shift = jsonDecoder[x].Shift
                model.belajar = "-"
                model.point = "0"
                model.skill = "-"
                
                dataFix.append(model)
           
                
                
                // nyimpen ke cloud
                saveProfil(name: model.nama, foto: model.photo, belajar: model.belajar, point: model.point, skill: model.skill, expertise: model.expertise, shift: model.shift, team: model.team)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "API"), object: self)
            }
           
            
        }
        
    }
    
    
    
    
    
    func saveProfil(name:String,foto:String,belajar:String,point:String,skill:String,expertise:String,shift:String,team:String){
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
