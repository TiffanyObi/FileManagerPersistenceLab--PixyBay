//
//  ImagesAPIClient.swift
//  FileManagerPersistenceLab
//
//  Created by Tiffany Obi on 1/21/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation
import NetworkHelper

struct ImagesAPIClient {

static func getImages(with searchQuery: String, completion: @escaping (Result<[Image],AppError>) -> () ) {
    
    let searchQuery = searchQuery
    
    let imagesEndpoint = "https://pixabay.com/api/?key=\(SecretKey.myKey)&q=\(searchQuery)"
    
    guard let url = URL(string: imagesEndpoint) else {
      completion(.failure(.badURL(imagesEndpoint)))
        return
    }
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { (result) in
        switch result {
        case .failure(let appError):
            completion(.failure(.networkClientError(appError)))
        case .success(let imageData):
            
            do {
                let imageInfo = try JSONDecoder().decode(AllImages.self, from: imageData)
                
            completion(.success(imageInfo.hits))
            } catch {
            completion(.failure(.decodingError(error)))
            }
        }
    }
    }
    
}
