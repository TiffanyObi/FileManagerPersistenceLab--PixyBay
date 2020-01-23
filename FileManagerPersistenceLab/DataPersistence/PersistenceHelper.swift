//
//  PersistenceHelper.swift
//  FileManagerPersistenceLab
//
//  Created by Tiffany Obi on 1/22/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation

enum DataPersistenceError: Error { // conforming to the Error protocol
  case savingError(Error) // associative value
  case fileDoesNotExist(String)
  case noData
  case decodingError(Error)
  case deletingError(Error)
}

class PersistenceHelper {
  
  // CRUD - create, read, update, delete
  
  // array of images
  private var images = [Image]()
    let filename = "favoritedImages.plist"
 public static let shared = PersistenceHelper()
  
  private func save() throws {
   
    // step 1.
     // get url path to the file that the Event will be saved to
     let url = FileManager.pathToDocumentsDirectory(with: filename)
    
    // images array will be object being converted to Data
    // we will use the Data object and write (save) it to documents directory
    do {
      // step 3.
      // convert (serialize) the images array to Data
      let data = try PropertyListEncoder().encode(images)
      
      // step 4.
      // writes, saves, persist the data to the documents directory
      try data.write(to: url, options: .atomic)
    } catch {
      // step 5.
      throw DataPersistenceError.savingError(error)
    }
  }
  
  // for re-ordering
  public func reorderEvents(item: [Image]) {
    self.images = item
    try? save()
  }
  
  // DRY - don't repeat yourself
  
  // create - save item to documents directory
  public func addToFavorites(item: Image) throws {
    // step 2.
    // append new event to the images array
    images.append(item)
    
    do {
      try save()
    } catch {
      throw DataPersistenceError.savingError(error)
    }
  }

  // read - load (retrieve) items from documents directory
  public func loadEvents() throws -> [Image] {
    // we need access to the filename URL that we are reading from
    let url = FileManager.pathToDocumentsDirectory(with: filename)
    
    // check if file exist
    // to convert URL to String we use .path on the URL
    if FileManager.default.fileExists(atPath: url.path) {
      if let data = FileManager.default.contents(atPath: url.path) {
        do {
          images = try PropertyListDecoder().decode([Image].self, from: data)
        } catch {
          throw DataPersistenceError.decodingError(error)
        }
      } else {
        throw DataPersistenceError.noData
      }
    }
    else {
      throw DataPersistenceError.fileDoesNotExist(filename)
    }
    return images
  }
  
  // delete - remove item from documents directory
  public func delete(event index: Int) throws {
    // remove the item from the images array
    images.remove(at: index)
    
    // save our images array to the documents directory
    do {
      try save()
    } catch {
      throw DataPersistenceError.deletingError(error)
    }
  }
}
