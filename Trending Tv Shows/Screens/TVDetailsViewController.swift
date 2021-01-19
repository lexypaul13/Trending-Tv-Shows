//
//  TVDetailsViewController.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/17/21.
//

import UIKit

class TVDetailsViewController: UIViewController {
    
    var tvImage = TvImage(frame: .zero)
    var titleLabel = TitleLabel(textAlignment: .left, fontSize: 34)
    var dateLabel = SecondaryLabel(fontSize: 10)
    var scoreLabel = SecondaryLabel(fontSize: 10)
    var bodyLabel = BodyLabel(textAlignment: .center)
    
    var shows: Shows!
    
    init( shows: Shows) {  ///user initialiser that enables UI configuration
        super.init(nibName: nil, bundle: nil)
        self.shows = shows
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureUIElements(){
        tvImage.downloadTVImage(shows.backdrop_path)
        titleLabel.text = shows.name
        dateLabel.text = shows.first_air_date
        scoreLabel.text = shows.vote_average
        bodyLabel.text = shows.overview
    }
    
    func addSubView(){
        view.addSubview(tvImage)
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.addSubview(scoreLabel)
        view.addSubview(bodyLabel)
    }
    
    func layoutUI() {
        let padding: CGFloat            = 20
        let textImagePadding: CGFloat   = 12
        
        NSLayoutConstraint.activate([
            tvImage.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            tvImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tvImage.widthAnchor.constraint(equalToConstant: 90),
            tvImage.heightAnchor.constraint(equalToConstant: 90),
            
            titleLabel.topAnchor.constraint(equalTo: tvImage.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: tvImage.trailingAnchor, constant: textImagePadding),
            titleLabel.trailingAnchor.constraint(equalTo: tvImage.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 38),
            
            dateLabel.centerYAnchor.constraint(equalTo: tvImage.centerYAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: tvImage.trailingAnchor, constant: textImagePadding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            scoreLabel.bottomAnchor.constraint(equalTo: tvImage.bottomAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: tvImage.trailingAnchor, constant: textImagePadding),
            scoreLabel.widthAnchor.constraint(equalToConstant: 20),
            scoreLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bodyLabel.topAnchor.constraint(equalTo: tvImage.bottomAnchor, constant: textImagePadding),
            bodyLabel.leadingAnchor.constraint(equalTo: tvImage.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bodyLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    

}
