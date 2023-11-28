//
//  TableViewCell.swift
//  ElectroCart
//
//  Created by Mohd Wasif Raza on 17/11/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let productImageView = UIImageView()
    let titleLabel = UILabel()
    let ratingLabel = UILabel()
    let priceLabel = UILabel()
    let imageCache = NSCache<NSString, UIImage>()
    let shadowLayer = ShadowView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        backgroundColor = .clear
        selectionStyle = .none

        addSubview(shadowLayer)
        shadowLayer.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        self.addSubview(productImageView)
        self.addSubview(titleLabel)
        self.addSubview(ratingLabel)
        self.addSubview(priceLabel)
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomConstraint = productImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        bottomConstraint.priority = .defaultHigh
        bottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            
            ratingLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            priceLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            shadowLayer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            shadowLayer.topAnchor.constraint(equalTo: self.topAnchor , constant: 7),
            shadowLayer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7),
            shadowLayer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7 )
        ])
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
            self.shadowLayer.layer.borderColor = UIColor.systemBlue.cgColor
            self.shadowLayer.layer.borderWidth = 1
        } else {
            self.shadowLayer.layer.borderWidth = 0
            
        }
    }
    
    func configureImage(fromUrl: String){
        guard let url = URL(string: fromUrl) else {return}
        
        if let imageCache = imageCache.object(forKey: fromUrl as NSString) {
            self.productImageView.image = imageCache
               return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) {[weak self]  data,_,error in
            guard error == nil else {
                return
            }
            if let imageData = data, let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self?.imageCache.setObject(image, forKey: fromUrl as NSString)
                    self?.productImageView.image = image
                }
            }
        }.resume()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    private func setupShadow(){
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.6
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 10, height: 10)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
