//
//  RecentViewController.swift
//  Trending Tv Shows
//
//  Created by Muhammad Awais on 05/06/2021.
//

import UIKit
import SideMenu
class RecentViewController: UIViewController{
    
    let tableView = UITableView()
    var recentShows : [Show] = []

  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewcontroller()
        setTableview()
        setupSideMenu()
        let sideMenuBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu"), style: .done, target: self, action: #selector(sideMenuTapped))

        self.navigationItem.leftBarButtonItem  = sideMenuBarButtonItem

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRecentShow()
    }
    
    func configureViewcontroller(){
        view.backgroundColor = .systemGray
        title = "Recent Viewed"
    }
    
    func setTableview(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TvTableViewCell.self, forCellReuseIdentifier: TvTableViewCell.resuseID)
    }
    
    func getRecentShow(){
        SaveManger.collectRecent{ [weak self ] result in
            guard let self = self else { return}
            switch result{
            case .success(let recents):
                self.recentShows = recents
                self.recentShows.reverse()
                DispatchQueue.main.async {self.tableView.reloadData()}
            case .failure( _):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Cannot", message: ErroMessage.saveFailure.rawValue,preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
            
            
        }
        
    }
    @IBAction func sideMenuTapped(_ sender: Any) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    
    func setupSideMenu(){
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        SideMenuManager.default.menuFadeStatusBar = false
        
        let menuLeftNavigationController = mainStoryboard.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.view)
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor.white
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuWidth = UIScreen.main.bounds.size.width
        
    }
}

extension RecentViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentShows.count
    }
     
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TvTableViewCell.resuseID) as! TvTableViewCell
        let recentShow = recentShows[indexPath.row]
        cell.setCell(favorite: recentShow)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = recentShows[indexPath.row]
        let destVC = Details_ViewController(showID: favorite.id!)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        let favorite = recentShows[indexPath.row]
        recentShows.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        SaveManger.updateWith(favorite: favorite, actionType: .remove, key: SaveManger.Keys.mostRecent) { [weak self] error in
            guard self != nil else { return }
            guard error != nil else { return }
            
        }
        
    }
}
