//
//  ProductViewController.swift
//  ElectroCart
//
//  Created by Mohd Wasif Raza on 26/11/23.
//

import Foundation
import UIKit

class ProductViewController: UIViewController {
    private let product: Product
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.backgroundStyle = .automatic
       
    
        return pageControl
    }()
    
    let imageCarousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
        return collectionView
    }()
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        imageCarousel.dataSource = self
        imageCarousel.delegate = self
        
        view.addSubview(imageCarousel)
        imageCarousel.translatesAutoresizingMaskIntoConstraints = false
        
        pageControl.numberOfPages = self.product.images.count
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            imageCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageCarousel.topAnchor.constraint(equalTo: view.topAnchor),
            imageCarousel.heightAnchor.constraint(equalToConstant: 300),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: imageCarousel.bottomAnchor)
        ])
    }
    
    func getCurrentPage() -> Int {
        let visibleRect = CGRect(origin: imageCarousel.contentOffset, size: imageCarousel.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = imageCarousel.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
            return currentPage
        }
    
}

extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.product.images.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ProductCollectionViewCell ?? ProductCollectionViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        cell.configureImage(fromUrl: self.product.images[indexPath.row])
        return cell
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 30 , height: collectionView.frame.height - 50)
    }
    
    
}
