//
//  FavoritesTableViewController.swift
//  FileManagerPersistenceLab
//
//  Created by Tiffany Obi on 1/22/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UIViewController {
    
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    
    
    var favorites = [Image](){
        didSet {
            DispatchQueue.main.async {
                self.favoritesTableView.reloadData()
               
        }
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.backgroundColor = .magenta
        
        loadFavoritedImages()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadFavoritedImages()
    }
    
    private func loadFavoritedImages() {
        do {
            try favorites = PersistenceHelper.shared.loadEvents()
        } catch {
            print("error loading favorited images - Error:  \(error)")
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let detailVC = segue.destination as? ImageDetailViewController, let indexPath = favoritesTableView.indexPathForSelectedRow else {
            fatalError("could not downcast to ImageDetailViewController ")
        }
        
        let cellInRow = favorites[indexPath.row]
        
        detailVC.imageDetails = cellInRow
        
        detailVC.removeButton = true
      
    }
}

extension FavoritesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let favoriteCell = favoritesTableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoritesTableViewCell else {
            fatalError("could not downcast to FavoritesTableViewCell")
        }
        
        let favoiteImageInRow = favorites[indexPath.row]
        
        favoriteCell.configureCell(for: favoiteImageInRow)
        
        return favoriteCell
        
    }
    
    
}

extension FavoritesTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
}
