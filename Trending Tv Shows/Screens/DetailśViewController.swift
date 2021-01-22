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
    var bodyLabel = BodyLabel(textAlignment: .center)
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
        configureUIElements()
        addSubView()
        layoutUI()
        getShowDetails()
    }
    
    func configureViewController (){
        view.backgroundColor = .systemBackground
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC) )
        navigationItem.rightBarButtonItem = done
    }
    
    @objc func dismssVC() {
        dismiss(animated: true)
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
    
    func getShowDetails(){
        NetworkManger.shared.get(.showDetail, showID: showID, page: nil, urlString: "") { [weak self] (show: Show?) in
            guard let self = self else { return }
            DispatchQueue.main.async {self.layoutUI()}
            
            
        }
  
    

}
}


   



