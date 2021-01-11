//
//  TextField.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/9/21.
//

import UIKit

class TextField: UITextField {

    override init(frame: CGRect){
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func set (){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 25
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray2.cgColor
        
        textColor = .label
        tintColor = .label
        font = UIFont.preferredFont(forTextStyle: .title2)
        
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        backgroundColor = .tertiarySystemGroupedBackground
        autocorrectionType = .no
        clearButtonMode = .whileEditing
        placeholder = "Search Trending Tv"
    }
    
    

}
