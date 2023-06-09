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
    let tvName = TitleLabel(textAlignment: .center, fontSize: 20 )
    
    override init (frame:CGRect){
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(show:Show){
        if let path = show.backdropPath{tvImage.downloadTVImage(path)}
        tvName.text = show.unwrappedName
    }
    
    private func set() {
        contentView.addSubview(tvImage)
        contentView.addSubview(tvName)
        tvImage.translatesAutoresizingMaskIntoConstraints = false
        tvName.translatesAutoresizingMaskIntoConstraints = false
        let padding : CGFloat = 8
        NSLayoutConstraint.activate([
            tvImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            tvImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            tvImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            tvImage.heightAnchor.constraint(equalTo: tvImage.widthAnchor),
            tvName.topAnchor.constraint(equalTo: tvImage.bottomAnchor, constant: 12),
            tvName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            tvName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),])
        
    }
}
