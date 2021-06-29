//
//  BaseViewModel.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import UIKit

class BaseViewModel: NSObject {
    var reloadListViewClosure: (()->())?
    var redirectControllerClosure: ((Any?)->())?
    var loadingIndicator: ((Bool) -> ())?
    
    func showIndicator(){
        loadingIndicator?(true)
    }
    
    func hideIndicator(){
        loadingIndicator?(false)
    }
}
