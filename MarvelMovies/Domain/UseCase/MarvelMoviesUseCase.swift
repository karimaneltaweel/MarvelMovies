//
//  MarvelMoviesUseCase.swift
//  MarvelMovies
//
//  Created by kariman eltawel on 19/11/2023.
//

import Foundation
import UIKit

protocol MarvelFilmsUseCaseProtocol{
    func fetchMarvelUseCae(view:UIView,limit:Int,offestNum:Int,completion: @escaping (MarvelFilms?) -> Void)
    func getFilmById(view:UIView,id:String,completion: @escaping (MarvelFilms?) -> Void)
    func saveInCoreData(filmDescription:String,filmEndYear:Int,filmId:Int)
    func fetchDataFromCore()->[FilmsDetailsResult]
}

class MarvelFilmsUseCase:MarvelFilmsUseCaseProtocol{
  
    func fetchMarvelUseCae(view:UIView,limit:Int,offestNum:Int,completion: @escaping (MarvelFilms?) -> Void) {
        NetworkService.request(url: URLs.Instance.getAllFilms(limit: limit, offest: offestNum), method: .get, view:view){  (data:MarvelFilms?) in
            completion(data)
        }
    }
    
    func getFilmById(view: UIView, id: String,completion: @escaping (MarvelFilms?) -> Void) {
        NetworkService.request(url: URLs.Instance.getFilmById(filmId: id), method: .get, view: view) { (data: MarvelFilms?) in
            completion(data)
        }
    }
    
    func saveInCoreData(filmDescription:String,filmEndYear:Int,filmId:Int){
        CoreDataManager.saveToCoreData(filmDescription: filmDescription, filmEndYear: filmEndYear, filmId: filmId)
    }
    
    func fetchDataFromCore()->[FilmsDetailsResult]{
        CoreDataManager.fetchFromCoreData()
    }
    
    
}
