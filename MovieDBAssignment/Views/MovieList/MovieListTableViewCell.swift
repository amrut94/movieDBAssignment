//
//  MovieListTableViewCell.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    //MARK:- @IBOutlets
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var imgViewPoster: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnBookNow: UIButton!
    
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
