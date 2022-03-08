//
//  ImageViewController.swift
//  ImageGallery
//
//  Created by Vasile Sebastian Catur on 07.03.2022.
//

import UIKit

class ImageCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate, UIDropInteractionDelegate {

    @IBOutlet weak var imagesCollectionView: UICollectionView! {
        didSet {
            imagesCollectionView.dataSource = self
            imagesCollectionView.delegate = self
            imagesCollectionView.dragDelegate = self
            imagesCollectionView.dropDelegate = self
        }
    }

    var imageListUrls = [String]()
    private var imageForZoom = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ScrollViewController {
            vc.stringImage = imageForZoom
        }
    }

    //MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageListUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        if let imageCell = cell as? ImageCollectionViewCell {
            imageCell.fetchImageFromUrl(urlString: imageListUrls[indexPath.row])
        }
        return cell
    }

    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageForZoom = imageListUrls[indexPath.row]
        performSegue(withIdentifier: "ImageZoom", sender: indexPath.row)
    }

    //MARK: - UICollectionViewDragDelegate

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        session.localContext = collectionView
        return dragItems(at: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        return dragItems(at: indexPath)
    }

    private func dragItems(at indexPath: IndexPath) -> [UIDragItem] {
        if let itemCell = (imagesCollectionView?.cellForItem(at: indexPath)) as? ImageCollectionViewCell, let image = itemCell.imageView.image {
            let dragItem = UIDragItem(itemProvider: NSItemProvider(object: image))
            dragItem.localObject = imageListUrls[indexPath.item]
            return [dragItem]
        } else {
            return []
        }
    }

    //MARK: - UICollectionViewDropDelegate

    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        let isSelf = (session.localDragSession?.localContext as? UICollectionView) == collectionView
        if isSelf {
            return session.canLoadObjects(ofClass: UIImage.self)
        } else {
            return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
        }
    }

    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        let isSelf = (session.localDragSession?.localContext as? UICollectionView) == collectionView
        return UICollectionViewDropProposal(operation: isSelf ? .move : .copy, intent: .insertAtDestinationIndexPath)
    }

    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        for item in coordinator.items {
            if let sourceIndexPath = item.sourceIndexPath {
                if let imageInfo = item.dragItem.localObject as? String {
                    collectionView.performBatchUpdates {
                        imageListUrls.remove(at: sourceIndexPath.item)
                        imageListUrls.insert(imageInfo, at: destinationIndexPath.item)
                        collectionView.deleteItems(at: [sourceIndexPath])
                        collectionView.insertItems(at: [destinationIndexPath])
                        print("11")
                    }
                    coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                }
            } else {
                var imageUrlLocal: URL!
                let placeholderContext = coordinator.drop(item.dragItem, to: UICollectionViewDropPlaceholder(insertionIndexPath: destinationIndexPath, reuseIdentifier: "DropPlaceholderCell"))
                item.dragItem.itemProvider.loadObject(ofClass: NSURL.self) { (provider, error) in
                    DispatchQueue.main.async {
                        if let url = provider as? URL {
                            imageUrlLocal = url.imageURL
                            print("22")
                        }

                        if imageUrlLocal != nil {
                            placeholderContext.commitInsertion(dataSourceUpdates: { insertionIndexPath in
                                self.imageListUrls.insert(imageUrlLocal.absoluteString, at: insertionIndexPath.item)
                                print("33")
                            })
                        } else {
                            placeholderContext.deletePlaceholder()
                            print("44")
                        }
                    }
                }
            }
        }
    }

    //MARK: - UIDropInteractionDelegate

    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
}
