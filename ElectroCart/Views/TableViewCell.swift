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

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemGray5
        
        self.addSubview(productImageView)
        self.addSubview(titleLabel)
        self.addSubview(ratingLabel)
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        // https://stackoverflow.com/questions/65934475/strange-behaviour-of-constraints-added-programatically-in-uitableviewcell-swif
        
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
            ratingLabel.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    

    
    func configureImage(fromUrl: String){
        guard let url = URL(string: fromUrl) else {return}
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard error == nil else {
                return
            }
            
            if let imageData = data, let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self.productImageView.image = image
                }
            }
            
        }.resume()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
