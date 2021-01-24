//
//  ViewController.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/5/21.
//

import UIKit

class FavoriteViewController: UIViewController{
    
    let tableView = UITableView()
    var favoriteShows : [Show] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewcontroller()
        setTableview()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavoriteShow()
    }
    func configureViewcontroller(){
        view.backgroundColor = .systemGray
        title = "Saved Tv Shows"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    func setTableview(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TvTableViewCell.self, forCellReuseIdentifier: TvTableViewCell.resuseID)
        
    }
    
    func getFavoriteShow(){
        SaveManger.collectFavorties{ [weak self ] result in
            guard let self = self else { return}
            switch result{
            case .success(let favorites):
                self.favoriteShows = favorites
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            case .failure( _):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Cannot", message: ErroMessage.saveFailure.rawValue,preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            }
            
            
        }
        
    }
    
}

extension FavoriteViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TvTableViewCell.resuseID) as! TvTableViewCell
        let favoriteShow = favoriteShows[indexPath.row]
        cell.setCell(favorite: favoriteShow)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favoriteShows[indexPath.row]
        let destVC = Details_ViewController(showID: favorite.id!)
        navigationController?.pushViewController(destVC, animated: true)
    }
    

}
