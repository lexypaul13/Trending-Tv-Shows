//
//  AnimationViewController.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/11/21.
//

import UIKit

fileprivate var containerView : UIView!

extension UIViewController{
    
    func showLoadingView(){
        containerView = UIView(frame:view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemPink
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25){ [self] in containerView.alpha = 0.8
            let activityIndicator =  UIActivityIndicatorView (style: .large)
            containerView.addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints =  false
            NSLayoutConstraint.activate([
                activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
            activityIndicator.startAnimating()
        }
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
   
    
    
}
