//
//  MoviesApi.swift
//  Movies_List
//
//  Created by Alejandro Arce on 23/1/23.
//

import Foundation
import UIKit

enum JsonError : Error {
    case missingData
    case codeError
    case timeOut
    case defaultError
}
class MoviesApi {
    static func fetchMoviesJsonByTitle(searchMovie: String, completion: @escaping(Result<[MovieModelTitle],JsonError>)->Void) {
        let headers = [
            "X-RapidAPI-Key": "65e0c416a3msh547ab48e6090bc6p19a999jsna07f64c82cb4",
            "X-RapidAPI-Host": "mdblist.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://mdblist.p.rapidapi.com/?s=\(searchMovie)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                //let httpResponse = response as? HTTPURLResponse
                let response = response as? HTTPURLResponse
                
                if response!.statusCode != 200 && response!.statusCode != 408 {
                    print("Error \(response!.statusCode)")
                    completion(.failure(.codeError))
                    return
                }
                if response!.statusCode == 408 {
                    completion(.failure(.timeOut))
                    return
                }
                if let _ = error {
                    completion(.failure(.defaultError))
                    return
                }
                guard let data = data else {
                    completion(.failure(.missingData))
                    return
                }
                do {
                    let json = try JSONDecoder().decode(Search.self, from: data)
                    completion(.success(json.search))
                    return
                } catch let error {
                    completion(.failure(.defaultError))
                    print(error.localizedDescription)
                    return
                }
            
        })
        dataTask.resume()
       
    }
    static func fetchMoviesJsonById(id: String, completion: @escaping(Result<MovieModelId,JsonError>)->Void) {
        let headers = [
            "X-RapidAPI-Key": "65e0c416a3msh547ab48e6090bc6p19a999jsna07f64c82cb4",
                "X-RapidAPI-Host": "mdblist.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://mdblist.p.rapidapi.com/?i=\(id)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                //let httpResponse = response as? HTTPURLResponse
                let response = response as? HTTPURLResponse
                
                if response!.statusCode != 200 && response!.statusCode != 408 {
                    print("Error \(response!.statusCode)")
                    completion(.failure(.codeError))
                    return
                }
                if response!.statusCode == 408 {
                    completion(.failure(.timeOut))
                    return
                }
                if let _ = error {
                    completion(.failure(.defaultError))
                    return
                }
                guard let data = data else {
                    completion(.failure(.missingData))
                    return
                }
                do {
                    let json = try JSONDecoder().decode(MovieModelId.self, from: data)
                    completion(.success(json))
                    return
                } catch let error {
                    completion(.failure(.defaultError))
                    print(error.localizedDescription)
                    return
                }
            
        })
        dataTask.resume()
       
    }
    static func downloadImages(url: URL, completionImage: @escaping(Result<UIImage,Error>)->Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Ha habido un error")
                completionImage(.failure(error!))
                return
            }
            if let image = UIImage(data: data) {
                completionImage(.success(image))
            }
        }.resume()
    }

    
}
