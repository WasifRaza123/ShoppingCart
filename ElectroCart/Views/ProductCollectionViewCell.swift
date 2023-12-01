//
//  ProductCollectionViewCell.swift
//  ElectroCart
//
//  Created by Mohd Wasif Raza on 26/11/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImage(fromUrl: String){
        guard let url = URL(string: fromUrl) else {return}
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) {[weak self]  data,_,error in
            guard error == nil else {
                return
            }
            
            if let imageData = data, let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    
                    self?.imageView.image = image
                }
            }
            
        }.resume()
    }
}
