//
//  NewGameResponse.swift
//  iOSCarePlus
//
//  Created by 임수현 on 2020/12/16.
//  Copyright © 2020 tngusmiso. All rights reserved.
//

import Foundation

struct NewGameScreenshotImage: Decodable {
    let url: String
}

struct NewGameScreenshot: Decodable {
    let images: [NewGameScreenshotImage]
}

struct NewGameContents: Decodable {
    let formalName: String
    let heroBannerURL: String
    let screenshots: [NewGameScreenshot]
    
    enum CodingKeys: String, CodingKey {
        case formalName = "formal_name"
        case heroBannerURL = "hero_banner_url"
        case screenshots
    }
}

struct NewGameResponse: Decodable {
    var contents: [NewGameContents]
    let length: Int
    let offset: Int
    let total: Int
}
