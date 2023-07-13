//
//  MovieViewController.swift
//  MovieTask
//
//  Created by Gaurav R on 12/07/23.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            let nib = UINib(nibName: "MovieViewCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "MovieViewCell")
            collectionView.backgroundColor = UIColor.lightGray
        }
    }

    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets( top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    var viewModel: movieDataProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpNavigationBar()
        self.loadData()
    }
    
    func setUpNavigationBar() {
        self.title = "Popular Movies"
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func loadData() {
        viewModel?.getData(completionHandler: {[weak self] isSuccess, errMsg in
            guard let weakSelf = self else { return }
            if isSuccess {
                DispatchQueue.main.async {
                    weakSelf.collectionView.reloadData()
                }
            } else {
                if let err = errMsg {
                    weakSelf.showAlert(message: err)
                }
            }
        })
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}


extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel?.getNumberOfItems() else { return 0 }
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath) as! MovieViewCell
        cell.configureCell(data: viewModel?.getItem(row: indexPath.row))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem + widthPerItem/2 + 42.0
        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.loadData()
    }

}

