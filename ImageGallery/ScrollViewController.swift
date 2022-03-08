//
//  ScrollViewController.swift
//  ImageGallery
//
//  Created by Vasile Sebastian Catur on 08.03.2022.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 0.1
            scrollView.maximumZoomScale = 5.0
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    var selectedImage: UIImage!
    var stringImage = ""
    private var imageFetcher: ImageFetcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageFetcher = ImageFetcher() { (url, image) in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        if let url = URL(string: stringImage) {
            imageFetcher.fetch(url)
        }
    }


    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        scrollViewHeight.constant = scrollView.contentSize.height
        scrollViewWidth.constant = scrollView.contentSize.width
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return containerView
    }
}
