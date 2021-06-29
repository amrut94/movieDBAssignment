//
//  APIConstant.swift
//  MovieDBAssignment
//
//  Created by AMRUT WAGHMARE on 28/06/21.
//

import Foundation

struct APIConstant {
    static let apiKey       = "853090cc033adb6171d974212d4fd44d"
    static let languageType = "en-US"
}

struct URLs {
    static let baseUrl      = "https://api.themoviedb.org/3/movie/"
    static let now_playing  = "now_playing"
    static let imageUrl     = "https://image.tmdb.org/t/p/original"
    static let reviews      = "/reviews"
    static let credits      = "/credits"
    static let similar      = "/similar"
}

struct APIKeys {
    static let api_key      = "api_key"
    static let language     = "language"
    static let page         = "page"
}
