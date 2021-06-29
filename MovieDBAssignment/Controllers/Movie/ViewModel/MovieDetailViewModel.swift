//
//  MovieDetailViewModel.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import UIKit

enum MovieDetailCell:Int {
    case movieDetail
    case castAndCrew
    case similarMovies
    case reviews
}


class MovieDetailViewModel: BaseViewModel {
    var movie : Results?
    var arrReview : [Review] = []
    var arrCastCrews:[Cast] = []
    var arrSimilarMovies:[Results] = []
    
    //MARK:- TableView Data
    func numberOfSections() -> Int {
        return  4
    }
    
    func titleForSection(section: Int) -> String {
        switch MovieDetailCell(rawValue: section) {
        case .movieDetail:
            return ""
        case .castAndCrew:
            return "Cast & Crews"
        case .similarMovies:
            return "Similar Movies"
        case .reviews:
            return "Reviews"
        case .none:
            return ""
        }
    }
    
    func numberOfRows(section: Int) -> Int
    {
        switch MovieDetailCell(rawValue: section) {
        case .movieDetail:
            return 1
        case .castAndCrew:
            return 1
        case .similarMovies:
            return 1
        case .reviews:
            return arrReview.count
        case .none:
            return 0
        }
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Any?
    {
        switch MovieDetailCell(rawValue: indexPath.section) {
        case .movieDetail:
            return movie
        case .castAndCrew:
            return nil
        case .similarMovies:
            return nil
        case .reviews:
            return arrReview[indexPath.row]
        case .none:
            return nil
        }
    }
    
    func heightForSection(section: Int) -> CGFloat {
        switch MovieDetailCell(rawValue: section) {
        case .movieDetail:
            return CGFloat.leastNormalMagnitude
        case .castAndCrew:
            return arrCastCrews.count > 0 ? 25 : CGFloat.leastNormalMagnitude
        case .similarMovies:
            return arrSimilarMovies.count > 0 ? 25 : CGFloat.leastNormalMagnitude
        case .reviews:
            return arrReview.count > 0 ? 25 : CGFloat.leastNormalMagnitude
        case .none:
            return CGFloat.leastNormalMagnitude
        }
    }
    
    func heightForRow(section: Int) -> CGFloat {
        switch MovieDetailCell(rawValue: section) {
        case .movieDetail:
            return UITableView.automaticDimension
        case .castAndCrew:
            return arrCastCrews.count > 0 ? UITableView.automaticDimension : 0
        case .similarMovies:
            return arrSimilarMovies.count > 0 ? UITableView.automaticDimension : 0
        case .reviews:
            return arrReview.count > 0 ? UITableView.automaticDimension : 0
        case .none:
            return 0.0
        }
    }
    //MARK:- Collection View Data
    func numberOfItems(section: Int) -> Int{
        return (MovieDetailCell(rawValue: section) == .castAndCrew) ? arrCastCrews.count : arrSimilarMovies.count
    }
    
    func itemAtIndexPath(indexPath: IndexPath, type: MovieDetailCell) -> Any? {
        return type == .castAndCrew ? arrCastCrews[indexPath.item] : arrSimilarMovies[indexPath.item]
    }
    
    //MARK:- APIs Call
    func getCastAndCrews(){
        MovieService().getCastAndCrews(viewModel: self,movieId: movie?.id ?? 0) { (response) in
            DispatchQueue.main.async {
                if let cast = response?.cast{
                    self.arrCastCrews.append(contentsOf: cast)
                }
                if let crews = response?.crew{
                    self.arrCastCrews.append(contentsOf: crews)
                }
                self.reloadListViewClosure?()
                self.getSimilarMovies()
            }
        }
    }
    
    func getSimilarMovies(){
        MovieService().getSimilarMovies(viewModel: self,movieId: movie?.id ?? 0) { (response) in
            DispatchQueue.main.async {
                if let movies = response?.results{
                    self.arrSimilarMovies.append(contentsOf: movies)
                }
                self.reloadListViewClosure?()
                self.getReviews()
            }
        }
    }
    
    func getReviews() {
        MovieService().getReviews(viewModel: self, movieId: movie?.id ?? 0) { (response) in
            DispatchQueue.main.async {
                if let results = response?.reviews{
                    self.arrReview.append(contentsOf: results)
                    self.reloadListViewClosure?()
                }
            }
        }
    }
}
