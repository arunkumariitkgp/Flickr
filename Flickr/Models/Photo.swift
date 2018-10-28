//
//  Photo.swift
//  Flickr
//
//  Created by Arun Kumar on 28/10/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import Foundation

struct Photo : Equatable {
    var farm : Int
    var isFamily : Bool
    var isFriend : Bool
    var isPublic : Bool
    var id : String
    var owner : String
    var secret : String
    var server : String
    var title : String
    
    init(_farm : Int, _id : String, _isFamily : Bool, _isFriend : Bool, _isPublic : Bool, _owner : String, _secret : String, _server : String, _title : String) {
        self.farm = _farm
        self.id = _id
        self.isFamily = _isFamily
        self.isFriend = _isFriend
        self.isPublic = _isPublic
        self.owner = _owner
        self.secret = _secret;
        self.server = _server
        self.title = _title
    }
}
