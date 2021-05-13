//
//  coba.swift
//  ElearningLog
//
//  Created by bevan christian on 08/05/21.
//

import Foundation

var cobanama = "bevan"

func load<T:Decodable>(_ fileName:String)->T{
    let data:Data
    //diambil dulu dari bundle
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError()
    }
    
   
    
    // diubah jadi data dulu
    do {
       data = try Data(contentsOf: file)
    } catch  {
        fatalError()
    }
    
    // baru di decode dan kalo berhasil di return
    
    do {
        let decoder = JSONDecoder()
        // kenapa T.self kok ga landmark soale T.self itu auto menuju ke model tiap json masing"
        return try decoder.decode(T.self, from: data)
    } catch  {
        fatalError()
    }
    
}
