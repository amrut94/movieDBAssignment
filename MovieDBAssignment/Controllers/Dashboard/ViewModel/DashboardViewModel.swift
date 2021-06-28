//
//  DashboardViewModel.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import UIKit

class DashboardViewModel: BaseViewModel {

    //MARK:- TableView Data
    func numberOfRows() -> Int
    {
        return 10
    }
    
    func cellForRowAt(indexPath: IndexPath) -> NSObject
    {
        return NSObject()
    }
}
