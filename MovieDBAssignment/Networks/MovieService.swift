//
//  MovieService.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 29/06/21.
//

import UIKit

public class MovieService: APIService {

    func getMovies(page: Int, completion:@escaping (Response?) -> Void){
        let params = [APIKeys.api_key : APIConstant.apiKey, APIKeys.language : APIConstant.languageType, APIKeys.page : page ] as [String : Any]
        super.startService(with: URLs.now_playing, parameters: params, model: Response.self) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    if let responseModel = response as? Response {
                        completion(responseModel)
                    }
                case .Error( let message):
                    print(message)
                }
            }
        }
    }
    
    func getReviews(movieId: Int,completion:@escaping (ReviewResponse?) -> Void){
        let params = [APIKeys.api_key : APIConstant.apiKey, APIKeys.language : APIConstant.languageType, APIKeys.page : 1 ] as [String : Any]
        super.startService(with: "\(movieId)/\(URLs.reviews)", parameters: params, model: ReviewResponse.self) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    if let responseModel = response as? ReviewResponse {
                        completion(responseModel)
                    }
                case .Error( let message):
                    print(message)
                }
            }
        }
    }
    
    func getCastAndCrews(movieId: Int,completion:@escaping (CastResponse?) -> Void){
        let params = [APIKeys.api_key : APIConstant.apiKey, APIKeys.language : APIConstant.languageType] as [String : Any]
        super.startService(with: "\(movieId)/\(URLs.credits)", parameters: params, model: CastResponse.self) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    if let responseModel = response as? CastResponse {
                        completion(responseModel)
                    }
                case .Error( let message):
                    print(message)
                }
            }
        }
    }
    func getSimilarMovies(movieId: Int,completion:@escaping (Response?) -> Void){
        let params = [APIKeys.api_key : APIConstant.apiKey, APIKeys.language : APIConstant.languageType, APIKeys.page : 1 ] as [String : Any]
        super.startService(with: "\(movieId)/\(URLs.similar)", parameters: params, model: Response.self) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    if let responseModel = response as? Response {
                        completion(responseModel)
                    }
                case .Error( let message):
                    print(message)
                }
            }
        }
    }
}
