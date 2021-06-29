//
//  ReviewTableViewCell.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 29/06/21.
//

import UIKit
import SDWebImage

class ReviewTableViewCell: UITableViewCell {
    
    //MARK:- @IBOutlets
    @IBOutlet weak var imgViewAuthor: UIImageView!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    
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
    func configureCell(review: Review){
        lblAuthor.text = review.author
        lblComment.text = review.content
        imgViewAuthor.sd_imageIndicator = SDWebImageActivityIndicator.white
        var imgUrl = review.author_details?.avatar_path ?? ""
        if(imgUrl.starts(with: "/")){
            imgUrl.remove(at: imgUrl.startIndex)
        }
        imgViewAuthor.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(systemName: "person.fill"))
    }
}
