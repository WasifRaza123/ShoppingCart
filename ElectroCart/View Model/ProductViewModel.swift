//
//  ProductViewModel.swift
//  ElectroCart
//
//  Created by Mohd Wasif Raza on 18/11/23.
//

import Foundation
class ProductViewModel {
    var eventHandler: (()-> Void)?
    
    var products: [Product] = [] {
        didSet{
            eventHandler?()
        }
    }
    
    
    func fetchProducts() {
        APICaller.shared.fetchData{ result in
            switch result {
            case .success(let data):
                self.products = data.products
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
