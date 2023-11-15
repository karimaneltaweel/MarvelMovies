//
//  MarvalFilmTableViewCell.swift
//  MarvelMovies
//
//  Created by kariman eltawel on 16/11/2023.
//

import UIKit

class MarvalFilmTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var filmMainView: UIView!
    @IBOutlet weak var filmExpendedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
