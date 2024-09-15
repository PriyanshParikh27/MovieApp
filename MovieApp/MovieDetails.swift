//
//  MovieDetails.swift
//  MovieApp
//
//  Created by Priyansh on 22/03/24.
//

import UIKit

class MovieDetails: UIViewController {

   
    @IBOutlet weak var DetailTitle: UILabel!
    
    @IBOutlet weak var DetailImage: UIImageView!
    
    @IBOutlet weak var DetailimdbID: UILabel!
    
    @IBOutlet weak var DetailYear: UILabel!
    
    @IBOutlet weak var DetailType: UILabel!
    
    var img = UIImage()
    var movieTitle = ""
    var movieYear = ""
    var imdbID = ""
    var movieType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DetailTitle.text = movieTitle
        DetailImage.image = img
        DetailYear.text = movieYear
        DetailimdbID.text = imdbID
        DetailType.text = movieType

    }
    


}
