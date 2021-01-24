//
//  DetailśViewController.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/21/21.
//

import UIKit

class Details_ViewController: UIViewController {
    
    
    var tvImage = TvImage(frame: .zero)
    var titleLabel = TitleLabel(textAlignment: .left, fontSize: 34)
    var dateLabel = SecondaryLabel(fontSize: 10)
    var scoreLabel = SecondaryLabel(fontSize: 10)
    var bodyLabel = BodyLabel(textAlignment: .left)
    var showID:Int
    var show: Show?
    
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
        view.backgroundColor = .systemBackground
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC))
        
        let add  = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        navigationItem.rightBarButtonItem = done
        navigationItem.leftBarButtonItem = add
    }
    
    @objc func dismssVC() {
        dismiss(animated: true)
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
        let show = Show(id: show.id, overview: show.overview, voteCount: nil, name: nil, backdropPath: nil, voteAverage: nil, firstAirDate: nil)
        
        SaveManger.updateWith(favorite: show, actionType: .add){ error in
            guard let error = error else{
                print("Saved")
                return
            }
            print("something went wrong")
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
        bodyLabel.text = show?.overview
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
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 10
        bodyLabel.numberOfLines = 0

        NSLayoutConstraint.activate([
            tvImage.topAnchor.constraint(equalTo: view.topAnchor,constant: 75),
            tvImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            tvImage.widthAnchor.constraint(equalToConstant: 140),
            tvImage.heightAnchor.constraint(equalToConstant: 140),
            tvImage.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor,constant: 25),
            
            titleLabel.topAnchor.constraint(equalTo: tvImage.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: tvImage.trailingAnchor, constant: textImagePadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 38),
            
            
            dateLabel.centerYAnchor.constraint(equalTo: tvImage.centerYAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: tvImage.trailingAnchor, constant: textImagePadding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 90),
            
            scoreLabel.topAnchor.constraint(equalTo: tvImage.topAnchor, constant: 90),
            scoreLabel.leadingAnchor.constraint(equalTo: tvImage.trailingAnchor, constant: textImagePadding),
            scoreLabel.widthAnchor.constraint(equalToConstant: 20),
            scoreLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bodyLabel.topAnchor.constraint(equalTo: tvImage.bottomAnchor, constant: textImagePadding),
            bodyLabel.leadingAnchor.constraint(equalTo: tvImage.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 15),
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






