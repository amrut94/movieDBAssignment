//
//  SearchViewModel.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import UIKit

class SearchViewModel: BaseViewModel {
    
    var arrMovies:[Results] = []
    var isSearchActive = false
    var downloadedMovies:[Results]?
    
    //MARK:- Functions
    func filterMovies(searchQuery:String){
        self.isSearchActive = searchQuery.count > 0
        if(self.isSearchActive){
            arrMovies = downloadedMovies?.filter({ (movie) in
                let arrSubtitles = movie.title?.components(separatedBy: " ") ?? []
                return (movie.title?.starts(with: searchQuery) ?? false) || (arrSubtitles.filter({$0.starts(with: searchQuery)}).count > 0)
            }) ?? []
        } else {
            arrMovies = (UserDefaults.getObjectFromUserDefaults(type: [Results].self, key: .movies) ?? [])
        }
        self.reloadListViewClosure?()
    }
    
    //MARK:- TableView Data
    func numberOfSections() -> Int {
        return isSearchActive ? 1 : 1
    }
    
    func titleForSection() -> String {
        return isSearchActive ? "" : "Recent Search"
    }
    
    func numberOfRows() -> Int
    {
        return arrMovies.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Results
    {
        return arrMovies[indexPath.row]
    }
    
    func didSelectRowAt(indexPath: IndexPath){
        let movie = arrMovies[indexPath.row]
        var movies = UserDefaults.getObjectFromUserDefaults(type: [Results].self, key: .movies) ?? []
        if !(movies.filter({$0.id == movie.id}).count > 0){
            if(movies.count >= 5) {
                movies.remove(at: (movies.count - 1))
            }
            movies.insert(movie, at: 0)
        }
       
        UserDefaults.saveObjectToUserDefaults(object: movies, key: .movies)
        redirectControllerClosure?(movie)
    }
}
