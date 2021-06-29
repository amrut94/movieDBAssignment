//
//  MovieDetailHeaderTableViewCell.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 29/06/21.
//

import UIKit
import SDWebImage

class MovieDetailHeaderTableViewCell: UITableViewCell {

    //MARK:- @IBOutlets
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK:- Configure Cell
    func configureCell(movie: Results){
        lblMovieName.text = movie.title
        lblDate.text = movie.release_date
        lblDescription.text = movie.overview
        lblRating.text = "Rating  \(movie.vote_average ?? 0.0)"
        imgMoviePoster.sd_imageIndicator = SDWebImageActivityIndicator.white
        imgMoviePoster.sd_setImage(with: URL(string: URLs.imageUrl+(movie.poster_path ?? "")), placeholderImage: UIImage(named: "moviePlaceholder"))
    }
}
