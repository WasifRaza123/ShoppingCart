//
//  ProductModel.swift
//  ElectroCart
//
//  Created by Mohd Wasif Raza on 16/11/23.
//

import Foundation

struct ProductModel: Codable {
    let products: [Product]
}
typealias Products = [Product]

struct Product: Codable{
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Float
    let rating: Float
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
    
}
