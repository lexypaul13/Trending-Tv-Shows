//
//  TvShowDetailsViewController.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/17/21.
//

import UIKit

class TvShowDetailsViewController: UIViewController {
    
    let showsView = UIView()
    var shows:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func configureViewController (){
        view.backgroundColor = .systemBackground
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismssVC) )
        navigationItem.rightBarButtonItem = done
    }
    
    @objc func dismssVC() {
        dismiss(animated: true)
    }
    
    
    func layoutUI(){
        view.addSubview(showsView)
        NSLayoutConstraint.activate([
            showsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            showsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            showsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            showsView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    
    
    func getShows(){

        
        
    }
    
    func add(childVC: UIViewController, containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}
