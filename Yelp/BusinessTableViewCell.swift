//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Marco Sgrignuoli on 9/24/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    var business: Business! {
        didSet {
            nameLabel.text = business.name
            thumbImageView.setImageWithURL(business.imageURL)
            categoriesLabel.text = business.categories
            addressLabel.text = business.address
            reviewsLabel.text = "\(business.reviewCount!) Reviews"
            ratingImageView.setImageWithURL(business.ratingImageURL)
            distanceLabel.text = business.distance
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Image corner radius
        thumbImageView.layer.cornerRadius = 5
        thumbImageView.clipsToBounds = true
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
