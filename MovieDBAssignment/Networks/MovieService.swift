//
//  MovieService.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 29/06/21.
//

import UIKit

public class MovieService: APIService {

    func getMovies(viewModel: BaseViewModel? ,page: Int, completion:@escaping (Response?) -> Void){
        let params = [APIKeys.api_key : APIConstant.apiKey, APIKeys.language : APIConstant.languageType, APIKeys.page : page ] as [String : Any]
        viewModel?.showIndicator()
        super.startService(with: URLs.now_playing, parameters: params, model: Response.self) { (result) in
            DispatchQueue.main.async {
                viewModel?.hideIndicator()
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
    
    func getReviews(viewModel: BaseViewModel?, movieId: Int,completion:@escaping (ReviewResponse?) -> Void){
        let params = [APIKeys.api_key : APIConstant.apiKey, APIKeys.language : APIConstant.languageType, APIKeys.page : 1 ] as [String : Any]
        viewModel?.showIndicator()
        super.startService(with: "\(movieId)/\(URLs.reviews)", parameters: params, model: ReviewResponse.self) { (result) in
            DispatchQueue.main.async {
                viewModel?.hideIndicator()
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
    
    func getCastAndCrews(viewModel: BaseViewModel?, movieId: Int,completion:@escaping (CastResponse?) -> Void){
        let params = [APIKeys.api_key : APIConstant.apiKey, APIKeys.language : APIConstant.languageType] as [String : Any]
        viewModel?.showIndicator()
        super.startService(with: "\(movieId)/\(URLs.credits)", parameters: params, model: CastResponse.self) { (result) in
            DispatchQueue.main.async {
                viewModel?.hideIndicator()
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
    func getSimilarMovies(viewModel: BaseViewModel?, movieId: Int,completion:@escaping (Response?) -> Void){
        let params = [APIKeys.api_key : APIConstant.apiKey, APIKeys.language : APIConstant.languageType, APIKeys.page : 1 ] as [String : Any]
        viewModel?.showIndicator()
        super.startService(with: "\(movieId)/\(URLs.similar)", parameters: params, model: Response.self) { (result) in
            DispatchQueue.main.async {
                viewModel?.hideIndicator()
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
