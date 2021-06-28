//
//  NSObject+Extension.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import Foundation
extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    class var className: String {
        return String(describing: self)
    }
}
