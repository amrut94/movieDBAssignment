//
//  DashboardViewModel.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import UIKit

class DashboardViewModel: BaseViewModel {

    var pageNo = 1
    var arrMovies:[Results] = []
    var isLoadMore = true
    
    //MARK:- Functions
    
    func pullDownRefresh(){
        pageNo = 1;
        isLoadMore = false
        arrMovies = []
        getMovies()
    }
    
    //MARK:- TableView Data
    func numberOfRows() -> Int
    {
        return arrMovies.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Results
    {
        if(indexPath.row == arrMovies.count-1 && isLoadMore){
            self.getMovies()
        }
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
    
    //MARK:- API Calls
    func getMovies() {
        MovieService().getMovies(viewModel: self,page: pageNo) { (response) in
            DispatchQueue.main.async {
                if let results = response?.results{
                    self.arrMovies.append(contentsOf: results)
                    self.isLoadMore = (response?.total_pages ?? 0) >= self.pageNo
                    self.pageNo += 1
                    self.reloadListViewClosure?()
                }
            }
        }
    }
}
