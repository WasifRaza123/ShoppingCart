//
//  StarView.swift
//  ElectroCart
//
//  Created by Mohd Wasif Raza on 30/11/23.
//

import UIKit

class StarView: UIStackView {
//    let rating: Float
    
    init(){
        super.init(frame: .zero)
    }
    
    func setUpStarStackView(rating: Float){
        for subview in self.arrangedSubviews {
            self.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        let roundStar = rating.rounded(.down)
        
        for i in 1...5 {
            if Float(i) <= roundStar || rating - roundStar > 0.8 {
                self.addArrangedSubview(setUpStarImage(systemName: "star.fill"))
            }
            else if  rating - roundStar > 0.2 {
                self.addArrangedSubview(setUpStarImage(systemName: "star.leadinghalf.filled"))
            }
            else {
                self.addArrangedSubview(setUpStarImage(systemName: "star"))
            }
        }
        
    }
    
    func setUpStarImage(systemName: String) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50 ))
        imageView.image = UIImage(systemName: systemName)?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        
        return imageView
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
