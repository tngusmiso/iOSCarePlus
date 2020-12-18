//
//  NewGameResponse.swift
//  iOSCarePlus
//
//  Created by 임수현 on 2020/12/16.
//  Copyright © 2020 tngusmiso. All rights reserved.
//

import Foundation

struct NewGameContents: Decodable {
    let formalName: String
    let heroBannerURL: String
    
    enum CodingKeys: String, CodingKey {
        case formalName = "formal_name"
        case heroBannerURL = "hero_banner_url"
    }
}

struct NewGameResponse: Decodable {
    let contents: [NewGameContents]
    let length: Int
    let offset: Int
    let total: Int
}
