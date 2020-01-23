//
//  FileManagerPersistenceLabTests.swift
//  FileManagerPersistenceLabTests
//
//  Created by Tiffany Obi on 1/21/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import XCTest
import NetworkHelper

@testable import FileManagerPersistenceLab

class FileManagerPersistenceLabTests: XCTestCase {

    func testUrlStringForData() {
       
        
        let exp = XCTestExpectation(description: "search found")
        let elementEndpointURL = "https://pixabay.com/api/?key=\(SecretKey.myKey)&q=20"
        let request = URLRequest(url: URL(string: elementEndpointURL)!)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
                
            case .success(let data):
                exp.fulfill()
                
                XCTAssertGreaterThan(data.count, 16_000, "data.count:\(data) should be greater that 16,000 bytes .")
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    func testImagesDataModel() {
        
        struct AllImages: Codable {
            let hits: [Image]
        }
        struct Image: Codable {
            let largeImageURL: String
            let webformatHeight: Double
            let likes: Double
            let pageURL: String
        }
        
        let expectedCount = 3
        let json = """
        {
            "totalHits": 328,
            "hits": [{
                    "largeImageURL": "https://pixabay.com/get/54e9d74a4356b108f5d08460962933771c3edfec564c704c72267dd0964dc450_1280.jpg",
                    "webformatHeight": 426,
                    "webformatWidth": 640,
                    "likes": 670,
                    "imageWidth": 3000,
                    "id": 292994,
                    "user_id": 13838,
                    "views": 309827,
                    "comments": 105,
                    "pageURL": "https://pixabay.com/photos/twitter-facebook-together-292994/",
                    "imageHeight": 2000,
                    "webformatURL": "https://pixabay.com/get/54e9d74a4356b108f5d08460962933771c3edfec564c704c72267dd0964dc450_640.jpg",
                    "type": "photo",
                    "previewHeight": 99,
                    "tags": "twitter, facebook, together",
                    "downloads": 149490,
                    "user": "LoboStudioHamburg",
                    "favorites": 637,
                    "imageSize": 2599503,
                    "previewWidth": 150,
                    "userImageURL": "https://cdn.pixabay.com/user/2012/11/18/16-48-54-297_250x250.jpg",
                    "previewURL": "https://cdn.pixabay.com/photo/2014/03/22/22/17/twitter-292994_150.jpg"
                },
                {
                    "largeImageURL": "https://pixabay.com/get/54e9d74a4356b108f5d08460962933771c3edfec564c704c72267dd0964dc450_1280.jpg",
                    "webformatHeight": 426,
                    "webformatWidth": 640,
                    "likes": 670,
                    "imageWidth": 3000,
                    "id": 292994,
                    "user_id": 13838,
                    "views": 309827,
                    "comments": 105,
                    "pageURL": "https://pixabay.com/photos/twitter-facebook-together-292994/",
                    "imageHeight": 2000,
                    "webformatURL": "https://pixabay.com/get/54e9d74a4356b108f5d08460962933771c3edfec564c704c72267dd0964dc450_640.jpg",
                    "type": "photo",
                    "previewHeight": 99,
                    "tags": "twitter, facebook, together",
                    "downloads": 149490,
                    "user": "LoboStudioHamburg",
                    "favorites": 637,
                    "imageSize": 2599503,
                    "previewWidth": 150,
                    "userImageURL": "https://cdn.pixabay.com/user/2012/11/18/16-48-54-297_250x250.jpg",
                    "previewURL": "https://cdn.pixabay.com/photo/2014/03/22/22/17/twitter-292994_150.jpg"
                },
                {
                    "largeImageURL": "https://pixabay.com/get/54e9d74a4356b108f5d08460962933771c3edfec564c704c72267dd0964dc450_1280.jpg",
                    "webformatHeight": 426,
                    "webformatWidth": 640,
                    "likes": 670,
                    "imageWidth": 3000,
                    "id": 292994,
                    "user_id": 13838,
                    "views": 309827,
                    "comments": 105,
                    "pageURL": "https://pixabay.com/photos/twitter-facebook-together-292994/",
                    "imageHeight": 2000,
                    "webformatURL": "https://pixabay.com/get/54e9d74a4356b108f5d08460962933771c3edfec564c704c72267dd0964dc450_640.jpg",
                    "type": "photo",
                    "previewHeight": 99,
                    "tags": "twitter, facebook, together",
                    "downloads": 149490,
                    "user": "LoboStudioHamburg",
                    "favorites": 637,
                    "imageSize": 2599503,
                    "previewWidth": 150,
                    "userImageURL": "https://cdn.pixabay.com/user/2012/11/18/16-48-54-297_250x250.jpg",
                    "previewURL": "https://cdn.pixabay.com/photo/2014/03/22/22/17/twitter-292994_150.jpg"
                }
            ]
        }
        """.data(using: .utf8)!
        
        let allimages = try! JSONDecoder().decode(AllImages.self, from: json)
        
        XCTAssertEqual(allimages.hits.count, expectedCount, "allImages.count is \(allimages.hits.count) which should be equal to the expectedCount which is \(expectedCount)")
    }

}
