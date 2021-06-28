//
//  SearchViewModel.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import UIKit

class SearchViewModel: BaseViewModel {
    
    var isSearchActive = false

    //MARK:- TableView Data
    func numberOfSections() -> Int {
        return isSearchActive ? 1 : 1
    }
    
    func titleForSection() -> String {
        return isSearchActive ? "" : "Recent Search"
    }
    
    func numberOfRows() -> Int
    {
        return 5
    }
    
    func cellForRowAt(indexPath: IndexPath) -> NSObject
    {
        return NSObject()
    }
}
