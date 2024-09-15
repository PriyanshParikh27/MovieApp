//
//  MyTableViewCell.swift
//  MovieApp
//
//  Created by Priyansh on 24/03/24.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var MovieImage: UIImageView!
    
    @IBOutlet weak var MovieName: UILabel!
    
    @IBOutlet weak var MovieYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
