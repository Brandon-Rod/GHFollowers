//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Brandon Rodriguez on 2/16/22.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    let tableView = UITableView()
    
    var favorites: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControler()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFavorites()
        
    }
    
    func configureViewControler() {
        
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        
        view.addSubview(tableView)
        tableView.frame =  view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        
    }
    
    func getFavorites() {
        
        PersistenceManager.retrieveFavorites { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let favorites):
                if favorites.isEmpty {
                    
                    self.showEmptyStateView(with: "You have no favorites.\nAdd a follower.", in: self.view)
                    
                } else {
                    
                    self.favorites = favorites
                    
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                        
                    }
                    
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    
                    self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                    
                }
                
            }
            
        }
        
    }

}

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {  return favorites.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let favorite = favorites[indexPath.row]
        let destVC = FollowerListVC(username: favorite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            
            guard let self = self else { return }
            
            guard let error = error else {
                
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
                
            }
            
            DispatchQueue.main.async {
                
                self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                
            }
            
        }

    }
    
}
