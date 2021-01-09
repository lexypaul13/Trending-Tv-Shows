//
//  BodyLabel.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/9/21.
//

import UIKit

class BodyLabel: UILabel {

    override init (frame:CGRect){
        super.init(frame:frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment:NSTextAlignment) {
        self.init(frame:.zero)
        self.textAlignment = textAlignment
    }
    
    private func configure () {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
