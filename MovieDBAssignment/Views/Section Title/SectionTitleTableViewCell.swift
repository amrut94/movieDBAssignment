//
//  SectionTitleTableViewCell.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import UIKit

class SectionTitleTableViewCell: UITableViewCell {
    
    //MARK:- @IBOutlet
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
