//
//  TodayViewController.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/6/21.
//

import UIKit
import SideMenu

class WeeklyViewController: UIViewController, UISearchBarDelegate {
    
    
    enum Section {
        case main
    }
    
    var collectionView :UICollectionView!
    var shows : [Show] = [] 
    
    var dataSource: UICollectionViewDiffableDataSource<Section,Show>!
    var filteredShows : [Show] = []
    var page = 1
    var show_ID = 0
    var isSearching = true
    var loadMoreMovies = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewcontroller()
        configureCollectionView()
        configureSearch()
        getTvshows(page:page)
        configureDataSource()
        setupSideMenu()
        let sideMenuBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu"), style: .done, target: self, action: #selector(sideMenuTapped))

        self.navigationItem.leftBarButtonItem  = sideMenuBarButtonItem
    }
    
    func configureViewcontroller(){
        view.backgroundColor = .systemGray
        
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
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(TvCellCollectionViewCell.self, forCellWithReuseIdentifier: TvCellCollectionViewCell.reuseID)
        self.configureDataSource()
        
    }
    
    
    func createThreeColumnFlowLayout()->UICollectionViewFlowLayout{
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var activeArray: Show

        if isSearching {
            activeArray = shows[indexPath.row]
        } else {
            activeArray = filteredShows[indexPath.row]
        }
        
        
        let show = Show(id: activeArray.id, overview: activeArray.overview, voteCount: activeArray.voteCount, name: activeArray.name, backdropPath: activeArray.backdropPath, voteAverage: activeArray.voteAverage, firstAirDate: activeArray.firstAirDate)
        
        SaveManger.updateWith(favorite: show, actionType: .add, key: SaveManger.Keys.mostRecent){ error in
            guard error != nil else{
            
                return
            }
        }
        
        
        let detailsVC = Details_ViewController(showID:show_ID)
        detailsVC.showID = activeArray.id ?? 0
        
        let navController   = UINavigationController(rootViewController: detailsVC)
        present(navController, animated: true)
    }
    
    
    
    func configureSearch(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Seach Tv Shows"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    
    func getTvshows(page:Int){
        showLoadingView()
        NetworkManger.shared.get(.showList, showID: nil, page: page, urlString: "") { [weak self] (response: ApiResponse? ) in
            self?.dismissLoadingView()
            guard let self = self else { return }
            guard let shows = response?.shows else {
             self.alert(message: "Check Internet Connection", title:  ErroMessage.unableToComplete.rawValue)
                return
            }
            DispatchQueue.main.async {
                if page == 1 {
                    self.shows = shows
                }else{
                    self.shows.append(contentsOf: shows)
                }
                self.updateData(shows: self.shows)
            }
            
        }
        
    }
    
    func updateUI(_ shows:[Show]){
        if self.shows.isEmpty{
            let alert = UIAlertController(title: "Tv Show Doesnt Exist", message: nil,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        self.updateData(shows: self.shows)
        
    }
    
    func updateData(shows:[Show]){ //shows follwers
        var snapshot = NSDiffableDataSourceSnapshot<Section,Show>()
        snapshot.appendSections([.main])
        snapshot.appendItems(shows)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Show>(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, show) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TvCellCollectionViewCell.reuseID, for: indexPath) as! TvCellCollectionViewCell
            cell.setCell(show: show)
            return cell
        })
    }
    
}

extension WeeklyViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != ""{
            isSearching = false
            filteredShows = shows.filter({$0.unwrappedName.lowercased().contains((searchController.searchBar.text ?? "").lowercased())})
            updateData(shows: filteredShows)
        }
        else {
            updateData(shows: shows)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(shows: filteredShows)
    }
}

extension WeeklyViewController:UICollectionViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight-height{
            guard loadMoreMovies else { return }
            page += 1 ///increments ppage number when screen reaches
            getTvshows(page: page)
        }
    }
}


