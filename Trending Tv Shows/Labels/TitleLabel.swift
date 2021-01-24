//
//  TitleLabel.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/9/21.
//

import UIKit

class TitleLabel: UILabel {

    override init (frame:CGRect){
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment:NSTextAlignment, fontSize:CGFloat){
        self.init(frame:.zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)

    }
    
    private func set(){
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.05
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    
}
