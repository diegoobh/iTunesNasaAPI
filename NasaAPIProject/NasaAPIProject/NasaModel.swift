//
//  NasaModel.swift
//  NasaAPIProject
//
//  Created by Diego Borrallo Herrero on 4/11/23.
//

import Foundation

struct NasaItem: Codable{
    
    let title: String
    let imgUrl: URL
    let explanation: String
    let hdurl: URL
    let date: String
    
    enum CodingKeys: String, CodingKey{
        case title = "title"
        case imgUrl = "url"
        case explanation = "explanation"
        case hdurl = "hdurl"
        case date = "date"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try values.decode(String.self, forKey: CodingKeys.title)
        imgUrl = try values.decode(URL.self, forKey: CodingKeys.imgUrl)
        explanation = try values.decode(String.self, forKey: CodingKeys.explanation)
        hdurl = try values.decode(URL.self, forKey: CodingKeys.hdurl)
        date = try values.decode(String.self, forKey: CodingKeys.date)
    }
}
