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
    
    //MARK:- TableView Data
    func numberOfRows() -> Int
    {
        return arrMovies.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Results
    {
        return arrMovies[indexPath.row]
    }
    
    //MARK:- API Calls
    func getMovies() {
        MovieService().getMovies(page: pageNo) { (response) in
            DispatchQueue.main.async {
                if let results = response?.results{
                    self.arrMovies.append(contentsOf: results)
                    self.pageNo += 1
                    self.reloadListViewClosure?()
                }
            }
        }
    }
}
