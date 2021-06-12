//
//  DetailśViewController.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/21/21.
//

import UIKit

class Details_ViewController: UIViewController {
    
    
    var tvImage = TvImage(frame: .zero)
    var titleLabel = SecondaryLabel(fontSize: 25)
    var dateLabel = SecondaryLabel(fontSize: 20)
    var scoreLabel = SecondaryLabel(fontSize: 20)
    var bodyLabel = BodyLabel(textAlignment: .left)
    var showID:Int
    var show: Show?
    var loadMoreMovies = true
   
    init(showID: Int) {
        self.showID = showID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureUIElements()
        addSubView()
        layoutUI()
        getShowDetails()
    }
    
    func configureViewController (){
        view.backgroundColor = .white
        title = "TV Show Details"
        let add  = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        navigationItem.rightBarButtonItem = add
    }
    
   
    
    @objc func addButton(){
        NetworkManger.shared.get(.showDetail, showID: showID, page: nil, urlString: "")
        {[weak self] (response: Show? ) in
            guard let self = self else{return}
            guard let show = response else {
                print("Saving error occured ")
                return
            }
            
            self.addShowsToFavorites(show: show)
            
        }
    }
    
    func addShowsToFavorites(show:Show){
        let show = Show(id: show.id, overview: show.overview, voteCount: show.voteCount, name: show.name, backdropPath: show.backdropPath, voteAverage: show.voteAverage, firstAirDate: show.firstAirDate)
        
        SaveManger.updateWith(favorite: show, actionType: .add, key: SaveManger.Keys.favorites){ error in
            guard error != nil else{
             self.alert(message: "Saved.", title:"")
                return
            }
             self.alert(message: "You already saved this.", title: "")
        }
    }
    
    
    
    func configureUIElements(){
        if let path = show?.backdropPath  {
            tvImage.downloadTVImage(path)
        } else {
            print("No Backdrop path")
        }
        titleLabel.text = show?.name
        dateLabel.text = show?.firstAirDate
        scoreLabel.text = show?.voteAverageStr
        
        if let text = show?.overview {
            bodyLabel.text = text
        }
        else{
            bodyLabel.text = "No Description"
        }
    }
    
    func addSubView(){
        tvImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tvImage)
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.addSubview(scoreLabel)
        view.addSubview(bodyLabel)
    }
    
    func layoutUI() {
        let textImagePadding: CGFloat   = 10
        bodyLabel.numberOfLines = 0

        NSLayoutConstraint.activate([
            tvImage.topAnchor.constraint(equalTo: view.topAnchor,constant: 56),
            tvImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            tvImage.widthAnchor.constraint(equalToConstant: 140),
            tvImage.heightAnchor.constraint(equalToConstant: 140),
            tvImage.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor,constant: 25),
            
            titleLabel.topAnchor.constraint(equalTo: tvImage.centerYAnchor, constant: -96),
            titleLabel.leadingAnchor.constraint(equalTo: tvImage.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 90),
            
            
            dateLabel.topAnchor.constraint(equalTo: tvImage.centerYAnchor, constant: -50),
            dateLabel.leadingAnchor.constraint(equalTo: tvImage.trailingAnchor, constant: textImagePadding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 90),
            
            scoreLabel.topAnchor.constraint(equalTo: tvImage.topAnchor, constant: 90),
            scoreLabel.leadingAnchor.constraint(equalTo: tvImage.trailingAnchor, constant: textImagePadding),
            scoreLabel.widthAnchor.constraint(equalToConstant: 50),
            scoreLabel.heightAnchor.constraint(equalToConstant: 50),
            
            bodyLabel.topAnchor.constraint(equalTo: tvImage.bottomAnchor, constant: textImagePadding),
            bodyLabel.leadingAnchor.constraint(equalTo: tvImage.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
        ])
    }
    
    func getShowDetails(){
        NetworkManger.shared.get(.showDetail, showID: showID, page: nil, urlString: "") { [weak self] (show: Show?) in
            guard let self = self else { return }
            self.show = show
            DispatchQueue.main.async {self.configureUIElements()}
            
        }
    }
    
    
    
}






