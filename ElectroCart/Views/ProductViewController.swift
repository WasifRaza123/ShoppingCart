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
    let addView = UIView()
    private let buyButton = UIButton()
    private let addToCartButton = UIButton()
    
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
        title = self.product.title
        imageCarousel.dataSource = self
        imageCarousel.delegate = self
        
        view.addSubview(imageCarousel)
        imageCarousel.translatesAutoresizingMaskIntoConstraints = false
        
        pageControl.numberOfPages = self.product.images.count
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addView)
        addView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addToCartButton)
        addToCartButton.setTitle("Add to Cart", for: .normal)
        addToCartButton.setTitleColor(.black, for: .normal)
        addToCartButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        addToCartButton.layer.borderWidth = 1
        addToCartButton.layer.cornerRadius = 5
        addToCartButton.layer.borderColor = UIColor.black.cgColor
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buyButton)
        buyButton.setTitle("Buy", for: .normal)
        buyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        buyButton.layer.borderWidth = 1
        buyButton.layer.cornerRadius = 5
        buyButton.layer.borderColor = UIColor.black.cgColor
        buyButton.backgroundColor = .yellow
        buyButton.setTitleColor(.black, for: .normal)
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            addView.heightAnchor.constraint(equalToConstant: 3),
            addView.widthAnchor.constraint(equalTo: view.widthAnchor),
            addView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            imageCarousel.topAnchor.constraint(equalTo: addView.bottomAnchor),
            imageCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageCarousel.heightAnchor.constraint(equalToConstant: 300),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: imageCarousel.bottomAnchor),
            
            addToCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addToCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addToCartButton.widthAnchor.constraint(equalToConstant: 120),
            
            buyButton.widthAnchor.constraint(equalToConstant: 120),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
            
            
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ProductCollectionViewCell
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
