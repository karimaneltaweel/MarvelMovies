//
//  APIServices.swift
//  MarvelMovies
//
//  Created by kariman eltawel on 17/11/2023.
//

import Foundation
class URLs {
    private init() {}
    static let Instance = URLs()
    let url = "http://gateway.marvel.com//v1/public/"
    
    func getAllFilms(limit:Int,offest:Int) -> String {
        url + "series?ts=1&apikey=db5c8fc0b76101aa46012521b7da1855&hash=d8686c1da64e81c70fded01f699776b2&limit=\(limit)&offset=\(offest)"
    }
    
    func getFilmById(filmId:String) -> String {
        url + "series/\(filmId)?ts=1&apikey=db5c8fc0b76101aa46012521b7da1855&hash=d8686c1da64e81c70fded01f699776b2"
    }
    
}
