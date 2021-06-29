//
//  CastAndMovieTableViewCell.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 29/06/21.
//

import UIKit

class CastAndMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionViewCastAndMovie: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
