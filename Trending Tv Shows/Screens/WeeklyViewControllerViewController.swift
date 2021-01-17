//
//  TodayViewController.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/6/21.
//

import UIKit

class WeeklyViewController: UIViewController, UISearchBarDelegate {

    
    enum Section {
        case main
    }
    
    var collectionView :UICollectionView!
    var shows : [Shows] = []
    var dataSource: UICollectionViewDiffableDataSource<Section,Shows>!
    var filteredShows : [Shows] = []
    var page = 1
    var isSearching = false
    var loadMoreMovies = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewcontroller()
        configureCollectionView()
        configureSearch()
        getTvshows(page:page)
        configureDataSource()

    }
    
    func configureViewcontroller(){
        view.backgroundColor = .systemGray
        
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
        NetworkManger.shared.getShows(page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result{
            case .success(let shows):
                if page == 1 {
                    self.shows = shows
                }else{
                    self.shows.append(contentsOf: shows)
                }
                
                self.updateData(shows: self.shows)
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Check Internet Connection", message: error.rawValue,preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func updateUI(_ shows:[Shows]){
        if self.shows.isEmpty{
            let alert = UIAlertController(title: "Tv Show Doesnt Exist", message: nil,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        self.updateData(shows: self.shows)
        
    }

    func updateData(shows:[Shows]){ //shows follwers
        var snapshot = NSDiffableDataSourceSnapshot<Section,Shows>()
        snapshot.appendSections([.main])
        snapshot.appendItems(shows)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
    }
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Shows>(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, shows) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TvCellCollectionViewCell.reuseID, for: indexPath) as! TvCellCollectionViewCell
            cell.setCell(shows: shows)
            return cell
        })
    }

}

extension WeeklyViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, filter.isEmpty else {
            shows.removeAll()
            updateData(shows: shows)
            isSearching = false
            return
        }
        isSearching = true
        filteredShows = shows.filter { $0.originalName.lowercased().contains(filter.lowercased()) }
        updateData(shows: filteredShows)
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


