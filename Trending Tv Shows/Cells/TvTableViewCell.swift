//
//  TvTableViewCell.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/21/21.
//

import UIKit

class TvTableViewCell: UITableViewCell {
    
    static let resuseID = "FavoriteCell"
    let tvImage = TvImage(frame: .zero)
    let tvName = TitleLabel(textAlignment: .left, fontSize: 23)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
     }
     
    func setCell(favorite:Show) {
        tvImage.downloadTVImage(favorite.backdropPath ?? "No image")
        tvName.text = favorite.name
    }
    
    
    private func set() {
        self.contentView.addSubview(tvImage)
        contentView.addSubview(tvName)
        
        tvImage.translatesAutoresizingMaskIntoConstraints = false
        tvName.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat    = 12

        NSLayoutConstraint.activate([
                tvImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                tvImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                tvImage.heightAnchor.constraint(equalToConstant: 60),
                tvImage.widthAnchor.constraint(equalToConstant: 60),

                // constrain to contentView, not self!
                //tvName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                tvName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                tvName.leadingAnchor.constraint(equalTo: tvImage.trailingAnchor, constant: 24),
                
                // these two lines should be tvName, not tvImage!
                //tvImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
                //tvImage.heightAnchor.constraint(equalToConstant: 40)
                tvName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
                tvName.heightAnchor.constraint(equalToConstant: 40)
            ])
      }
}
