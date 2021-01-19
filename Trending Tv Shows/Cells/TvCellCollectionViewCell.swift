//
//  TvCellCollectionViewCell.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/9/21.
//

import UIKit

class TvCellCollectionViewCell: UICollectionViewCell {
  
    static let reuseID = "Tvcell"
    let tvImage = TvImage(frame: .zero)
    let tvName = TitleLabel(textAlignment: .center, fontSize: 15)
    
    override init (frame:CGRect){
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(shows:Shows){
        tvImage.downloadTVImage(shows.backdrop_path)
        tvName.text = shows.name
    }
    
    private func set() {
        addSubview(tvImage)
        addSubview(tvName)
        let padding : CGFloat = 8
        NSLayoutConstraint.activate([
            tvImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            tvImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            tvImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            tvImage.heightAnchor.constraint(equalTo: tvImage.widthAnchor),

            tvName.topAnchor.constraint(equalTo: tvImage.bottomAnchor, constant: 12),
            tvName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            tvName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            tvName.heightAnchor.constraint(equalToConstant: 20)  ])
        
    }
    
}
