//
//  TVInfoViewController.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/20/21.
//

import UIKit

import UIKit

class TVInfoViewController: UIViewController {
    
    let showsView = UIView()
    var showID:Int
    var show: Show?{
        didSet{
            print(show)
        }
    }
    
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
        layoutUI()
        getShowDetails()
        
        
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
            showsView.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {//adds childview to container
        addChild(childVC)
        containerView.addSubview(childVC.view) ///adds childview
        childVC.view.frame = containerView.bounds //sets the size
        childVC.didMove(toParent: self)
    }
    
    func getShowDetails(){
        NetworkManger.shared.get(.showDetail, showID: showID, page: nil, urlString: "") { [weak self] (show: Show?) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.add(childVC: TVDetailsViewController(coder: <#NSCoder#>)!, to: self.showsView)}
            
            
        }

    
        
        
    }
    
    
   

}
