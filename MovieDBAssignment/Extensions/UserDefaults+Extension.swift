//
//  UserDefaults+Extension.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 29/06/21.
//

import Foundation

extension UserDefaults {
    
    enum Keys: String, CaseIterable {
        case movies
    }
    
     func restUserDefaults() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue)
        }
    }
    
    static func saveObjectToUserDefaults<T:Codable>(object: T, key: Keys) {
        let encodedUser = try? JSONEncoder().encode(object)
        UserDefaults.standard.set(encodedUser, forKey: key.rawValue)
    }
    
    static func getObjectFromUserDefaults<T:Codable>(type: T.Type,key: Keys) -> T?{
        if let obj = UserDefaults.standard.object(forKey: key.rawValue) as? Data, let model = try? JSONDecoder().decode(type.self, from: obj) {
            return model
        }
        return nil
    }
}
