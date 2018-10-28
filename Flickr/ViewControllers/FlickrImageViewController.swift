//
//  FlickrImageViewController.swift
//  Flickr
//
//  Created by Arun Kumar on 28/10/18.
//  Copyright © 2018 Arun Kumar. All rights reserved.
//

import UIKit

class FlickrImageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet var imageCollectionView: UICollectionView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!

    var viewModel = ImageViewModel()
    var isPageRefeshing : Bool = false
    var searchText = String()
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityView.isHidden = true
    }
    
    //MARK: - Collection view related
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count;
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        let photo = viewModel.photos[indexPath.row] as Photo
        let imageURL = String("http://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg")
        cell.imageView.imageFromURL(imageURL, placeHolder: UIImage.init(named: "placeholder"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let dim = (collectionView.bounds.width - 6) / 3.0;
        return CGSize(width: dim, height: dim)
    }
    
    //MARK: - Scrollview delegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if imageCollectionView.contentOffset.y >= (imageCollectionView.contentSize.height - imageCollectionView.bounds.height) {
            if isPageRefeshing == false {
                if viewModel.pageNumber < viewModel.totalPageCount {
                    isPageRefeshing = true
                    activityView.isHidden = false
                    activityView.startAnimating()
                    viewModel.fetchImages(withText: searchText, pageNumber: viewModel.pageNumber) { (photos) in
                        DispatchQueue.main.async {
                            self.isPageRefeshing = false
                            self.activityView.isHidden = true
                            self.activityView.stopAnimating()
                            self.imageCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Search bar delegate
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        guard let text = searchBar.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) else {
            return
        }
        if text.count > 0 {
            searchText = text
            viewModel.photos.removeAll()
            viewModel.pageNumber = 1
            activityView.isHidden = false
            activityView.startAnimating()
            viewModel.fetchImages(withText: searchText, pageNumber: viewModel.pageNumber) { (photos) in
                DispatchQueue.main.async {
                    self.activityView.isHidden = true
                    self.activityView.stopAnimating()
                    self.imageCollectionView.reloadData()
                }
            }
        }
    }
}
