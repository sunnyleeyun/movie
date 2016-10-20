//
//  MovieTableViewCell.swift
//  Movie
//
//  Created by Sunny on 2016/10/20.
//  Copyright © 2016年 devhubs. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var userRating: UserRating!
    @IBOutlet weak var movieFormatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func configureCell(movie: Movie){
        movieTitleLabel.text = movie.title
        movieFormatLabel.text = movie.format
        userRating.rating = Int(movie.userRating)
        
        let imageData = movie.image as! Data
        movieImageView.image = UIImage(data: imageData)
    }

}
