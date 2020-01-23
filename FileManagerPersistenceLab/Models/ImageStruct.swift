//
//  ImageStruct.swift
//  FileManagerPersistenceLab
//
//  Created by Tiffany Obi on 1/21/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation

struct AllImages: Codable {
    let hits: [Image]
}

struct Image: Codable {
    let largeImageURL: String
    let webformatHeight: Double
    let likes: Double
    let pageURL: String
    let views:Double
    let comments: Double
    let tags : String
    let downloads:Double
}
