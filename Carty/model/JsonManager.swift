//
//  JsonManager.swift
//  Carty
//
//  Created by Jimmy on 29/08/2023.
//

import Foundation

struct Result: Codable{
    let products: [jsonProduct]
    let total: Int64
    let skip: Int64
    let limit: Int64
}

struct jsonProduct: Codable{
    let id: Int64
    let title: String
    let description: String
    let price: Int64
    let discountPercentage: Double
    let rating: Double
    let stock: Int64
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}

class JsonManager{
    static let JM = JsonManager()
    private init(){}
    
    func getData(completionHandler: @escaping (Any?) -> Void){
        let url = URL(string: "https://dummyjson.com/products")
        URLSession.shared.dataTask(with: url!,completionHandler:{ data, response, error in
            
            if let error = error{
                completionHandler(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completionHandler("invalid response")
                return
            }
            
            guard let data = data else {
                completionHandler("no data found")
                return
            }
            if let json = try? JSONDecoder().decode(Result.self, from: data){
                completionHandler(json.products)
            }
        }).resume()
    }
}
