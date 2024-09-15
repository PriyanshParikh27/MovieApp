//
//  MovieClass.swift
//  MovieApp
//
//  Created by Priyansh on 24/03/24.
//

import Foundation

class Movie {
    var title: String
    var year: String
    var posterURL: String
    var imdbID: String
    var type: String
    
    init(mName:String,mYear:String,mPoster:String,mimbdID:String,mType:String)
    {
        title=mName
        year=mYear
        posterURL=mPoster
        imdbID=mimbdID
        type=mType
    }
}

