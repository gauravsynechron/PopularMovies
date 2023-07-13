//
//  MovieViewCell.swift
//  MovieTask
//
//  Created by Gaurav R on 12/07/23.
//

import UIKit
import SDWebImage

class MovieViewCell: UICollectionViewCell {
    @IBOutlet weak var parentView: UIView! {
        didSet {
            parentView.layer.cornerRadius = 8.0
            parentView.clipsToBounds = true
        }
    }
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configureCell(data: MovieData?) {
        movieNameLbl.text = data?.title
        if let posterUrl = data?.poster_path, let url = URL(string: "\(MovieURL.imageBaseUrl)\(posterUrl)") {
            movieImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "movie"), progress: nil)
        }
    }

}
