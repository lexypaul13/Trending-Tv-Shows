//
//  SecondaryLabel.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/9/21.
//

import UIKit

class SecondaryLabel: UILabel {
    
    override init(frame:CGRect){
        super.init(frame: frame)
        set()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize:CGFloat){
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    private func set(){
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = false
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }


}
