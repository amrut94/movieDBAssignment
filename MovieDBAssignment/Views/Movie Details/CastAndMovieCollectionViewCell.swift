//
//  CastAndMovieCollectionViewCell.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 29/06/21.
//

import UIKit
import SDWebImage

class CastAndMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK:- Configure cell
    func configureCastCell(cast: Cast){
        lblTitle.text = cast.name
        imgView.sd_imageIndicator = SDWebImageActivityIndicator.white
        imgView.sd_setImage(with: URL(string: URLs.imageUrl+(cast.profile_path ?? "")), placeholderImage: UIImage(named: "userPlaceholder"))
    }
    func configureMovieCell(movie: Results){
        lblTitle.text = movie.title
        imgView.sd_imageIndicator = SDWebImageActivityIndicator.white
        imgView.sd_setImage(with: URL(string: URLs.imageUrl+(movie.poster_path ?? "")), placeholderImage: UIImage(named: "moviePlaceholder"))
    }
}
