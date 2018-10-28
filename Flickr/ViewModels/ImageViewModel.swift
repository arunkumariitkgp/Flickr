//
//  ImageViewModel.swift
//  Flickr
//
//  Created by Arun Kumar on 28/10/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class ImageViewModel: NSObject {
    
    var pageNumber : Int = 0
    var totalPageCount : Int = 0
    let apiManager = APIManager()
    var photos = [Photo]()
    
    func fetchImages(withText : String,
                   pageNumber : Int,
                   completion : @escaping (_ photos : [Photo]) -> ()) {
        
        apiManager.getImagesWithText(withText, pageNumber) { (response) in
            let dict = response["photos"] as? [String : Any]
            self.totalPageCount = dict?["pages"] as! Int
            self.pageNumber += 1
            guard let photoArray = dict?["photo"] as? [[String : Any]] else {
                return
            }
            for photo in photoArray {
                let photoObject = Photo(_farm: photo["farm"] as! Int,
                                        _id: photo["id"] as! String,
                                        _isFamily: photo["isfamily"] as! Bool,
                                        _isFriend: photo["isfriend"] as! Bool,
                                        _isPublic: photo["ispublic"] as! Bool,
                                        _owner: photo["owner"] as! String,
                                        _secret: photo["secret"] as! String,
                                        _server: photo["server"] as! String,
                                        _title: photo["title"] as! String)
                self.photos.append(photoObject)
            }
            completion(self.photos)
        }
    }
}
