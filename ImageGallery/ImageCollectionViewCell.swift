//
//  ImageCollectionViewCell.swift
//  ImageGallery
//
//  Created by Vasile Sebastian Catur on 07.03.2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    var imageFetcher: ImageFetcher!

    func fetchImageFromUrl(urlString: String) {
        imageFetcher = ImageFetcher() { (url, image) in
            DispatchQueue.main.async {
                self.imageView.image = image
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
            }
        }
        if let url = URL(string: urlString) {
            imageFetcher.fetch(url)
        }
    }
}
