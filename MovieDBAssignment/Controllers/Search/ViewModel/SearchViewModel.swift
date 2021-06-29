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
    var arrDownloadedMovies:[Results]?
    
    //MARK:- Functions
    func filterMovies(searchQuery:String){
        self.isSearchActive = searchQuery.count > 0
        if(self.isSearchActive){
            arrMovies = arrDownloadedMovies?.filter({ (movie) in
            return filterSearchData(movie: movie, searchQuery: searchQuery)
            }) ?? []
        } else {
            arrMovies = (UserDefaults.getObjectFromUserDefaults(type: [Results].self, key: .movies) ?? [])
        }
        self.reloadListViewClosure?()
    }
    
    
    //algorithm login for search movies
    
    func filterSearchData(movie: Results, searchQuery: String) -> Bool {
        let arrSubtitles = movie.title?.lowercased().components(separatedBy: " ") ?? []
        var arrSearchQuery = searchQuery.lowercased().components(separatedBy: " ")
        arrSearchQuery = arrSearchQuery.filter({$0 != ""})
        
        var isPresent = false
        
        //Check the search query contains any of the words in movie title
        for subtitle in arrSubtitles {
            if subtitle.starts(with: arrSearchQuery.last ?? ""){
                isPresent = true
            }
        }
        
        //Checked whether the search data is subset of array of movie words except last search word as we contineoulsy writing it
        
        let titleSet = Set(arrSubtitles)
        var searchQuerySet = Set<String>()
        if (arrSearchQuery.count > 1) {
            arrSearchQuery.removeLast()
            searchQuerySet = Set(arrSubtitles)
            isPresent = isPresent && searchQuerySet.isSubset(of: titleSet)
        }
        
        return isPresent
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
