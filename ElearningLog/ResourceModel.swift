//
//  ResourceModel.swift
//  ElearningLog
//
//  Created by bevan christian on 05/05/21.
//

import Foundation

struct resourcemodel:Codable{
    var records:[resource]
}

struct resource:Codable {
    var id:String
    var fields:resourcedetail
}


struct resourcedetail:Codable {
    var ResourcesLink:String?
    var ActivityResourceName:String?
    var Challenge:String
    enum CodingKeys : String, CodingKey {
        case ResourcesLink = "Resources Link"
        case ActivityResourceName = "Activity / Resource Name"
        case Challenge
    }
}



