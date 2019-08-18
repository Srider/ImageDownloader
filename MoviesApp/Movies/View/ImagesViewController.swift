//
//  MovieViewController.swift
//  MoviesApp
//
//  Created by Srikar on 07/08/19.
//  Copyright © 2019 Srikar. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ImagesViewController: UIViewController {

    var imagePresenter:ViewToPresenterProtocol?
    
    @IBOutlet weak var objImagesListView: UICollectionView!
    @IBOutlet weak var objTabListView: UICollectionView!

    var arrTabItems:Array<String>! = ["Discover", "Now Playing", "Popular", "Top Rated"]
    var arrImages:Array<Image> = Array()
    
    var nPageNumber:Int! = 1
    var nCurrentIndex:Int! = 0
    var nPreviousIndex:Int! = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPageTitle()
        Utilities.sharedInstance.addProgressIndicator(self.view)

        imagePresenter?.fetchImagesBasedOnSelection(0, andPage: 1)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: {
            _ in
            self.objTabListView!.collectionViewLayout.invalidateLayout()
        })
    }
    
    func setPageTitle()->Void {
        self.title = arrTabItems[self.nCurrentIndex]
    }
    
    func reloadView()->Void {
        if self.arrImages.count > 0 {
            self.objImagesListView?.dataSource = self
            self.objImagesListView?.delegate = self
            self.objImagesListView?.prefetchDataSource = self
            
            self.arrImages = Utilities.sharedInstance.sortItemsBasedOnUserName(self.arrImages)
            
            DispatchQueue.main.async {
                self.setPageTitle()
                self.objImagesListView?.reloadData()
            }
        }
    }
}

extension ImagesViewController:PresenterToViewProtocol{
    func refreshImageData(imageArray: Array<Image>) {
        self.arrImages = imageArray
        self.reloadView()
    }
    
    func showImages(imageArray: Array<Image>) {
        Utilities.sharedInstance.removeProgressIndicator()
        if self.nPageNumber == 1 {
           self.arrImages = imageArray
        } else {
            self.arrImages.append(contentsOf: imageArray)
        }
        
        self.reloadView()
        
        if self.arrImages.count > 0 {
            self.imagePresenter?.fetchImagesForItems(self.arrImages)
        }
    }
    
    func showError() {
        Utilities.sharedInstance.removeProgressIndicator()

        let alert = UIAlertController(title: "Network Failure", message: "Problem Fetching Images", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ImagesViewController:UICollectionViewDataSource {
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var items:Int! = 0
        if collectionView.tag == 0 {
            items = arrTabItems.count
        } else {
            items = arrImages.count
        }
        return items
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        var cell:UICollectionViewCell? = nil
        
        if collectionView.tag == 0 {
            let objTabCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.kTabCell, for: indexPath as IndexPath) as! TabCell
            objTabCell.lblTabName?.text = arrTabItems[indexPath.item]
            objTabCell.viewHolder?.layer.cornerRadius = 3.0
            
            if self.nCurrentIndex == indexPath.item {
                objTabCell.viewHolder?.backgroundColor = UIColor.orange
            } else {
                objTabCell.viewHolder?.backgroundColor = UIColor.clear
            }
            
            switch indexPath.item {
            case 0:
                objTabCell.imgTabImage?.image = UIImage(named: "discover")
            case 1:
                objTabCell.imgTabImage?.image = UIImage(named: "now-playing")
            case 2:
                objTabCell.imgTabImage?.image = UIImage(named: "popular")
            case 3:
                objTabCell.imgTabImage?.image = UIImage(named: "top-rated")
            default:
                objTabCell.imgTabImage?.image = UIImage(named: "now-playing")
            }
            
            cell = objTabCell as UICollectionViewCell
            cell?.contentView.setNeedsDisplay()
        } else {
            let objImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.kImageInfoCell, for: indexPath as IndexPath) as! ImageInfoCell
            objImageCell.configureCellWithData(arrImages[indexPath.item])
            cell = objImageCell as UICollectionViewCell
            cell?.contentView.setNeedsDisplay()
        }
        return cell!
    }
}


extension ImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        var insets:UIEdgeInsets! = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        if collectionView.tag == 0 {
            insets.left = 0
            insets.right = 0
        } else {
            insets.top = 5
            insets.bottom = 5
            insets.left = 5
            insets.right = 5
        }
        
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // your code here
        var size:CGSize! = CGSize.init(width: 0, height: 0)
        
        if collectionView.tag == 0 {
            size.height = 50
            size.width = self.view.frame.size.width/4
        } else {
            size.height = 185
            size.width = 125
        }
        return size
    }
}

extension ImagesViewController:UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetch: \(indexPaths)")
    }
}

extension ImagesViewController:UICollectionViewDelegate {
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        if collectionView.tag == 0 {
            if self.nCurrentIndex != self.nPreviousIndex {
                self.nPageNumber = 1
            }
            self.nPreviousIndex = self.nCurrentIndex
            self.nCurrentIndex = indexPath.item
            self.objTabListView?.reloadData()
            Utilities.sharedInstance.addProgressIndicator(self.view)
            imagePresenter?.fetchImagesBasedOnSelection(self.nCurrentIndex, andPage: self.nPageNumber)
        } else {
            //Disable Selection
        }
    }
}

extension ImagesViewController:UIScrollViewDelegate {
    
    //MARK: UIScrollviewDelegate methods
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0 {
            print("up")
        } else {
            print("down")
            self.nPageNumber = self.nPageNumber + 1
            Utilities.sharedInstance.addProgressIndicator(self.view)
            imagePresenter?.fetchImagesBasedOnSelection(self.nCurrentIndex, andPage: self.nPageNumber)
        }
    }
}
