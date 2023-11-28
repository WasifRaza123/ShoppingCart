//
//  APICaller.swift
//  ElectroCart
//
//  Created by Mohd Wasif Raza on 16/11/23.
//

import Foundation
class APICaller{
    static let shared = APICaller()
    
    func fetchData(completion: @escaping (Result<ProductModel,Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            return
        }
        URLSession.shared.dataTask(with: URLRequest(url: url)){ data, response ,error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.invalidURLError))
                return
            }
            do {
                let result = try JSONDecoder().decode(ProductModel.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }.resume()
    }
    
    func configureImage(fromUrl: String, completion: @escaping (Result<Data,Error>) -> Void){
        guard let url = URL(string: fromUrl) else {return}
        
//        if let imageCache = imageCache.object(forKey: fromUrl as NSString) {
//            self.productImageView.image = imageCache
//               return
//        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) {  data,_,error in
            guard error == nil else {
                completion(.failure(APIError.invalidURLError))
                return
            }
            
            if let imageData = data {
                completion(.success(imageData))
            }
            
        }.resume()
    }
    
    enum APIError: Error {
        case failedToGetData
        case invalidURLError
    }
}
