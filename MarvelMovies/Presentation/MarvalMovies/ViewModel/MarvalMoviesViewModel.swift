//
//  MarvalMoviesViewModel.swift
//  MarvelMovies
//
//  Created by kariman eltawel on 17/11/2023.
//

import Foundation
import Alamofire
import NVActivityIndicatorView

class MarvalMoviesViewModel {
    
    var MarvelFilmsBinding : (() -> ()) = {}
    var fetchAllMovies: [FilmsResult] = []{
        didSet{
            //bind the result
            MarvelFilmsBinding()
        }
    }
    var filmByIdBinding: (() -> ()) = {}
    var filmDetails : [FilmsResult] = []{
        didSet{
            filmByIdBinding()
        }
    }
    var filmFromCoreBinding: (() -> ()) = {}
    var filmsFromCoreData : [FilmsDetailsResult] = []
    var filmFromCore:FilmsDetailsResult?{
        didSet{
            filmFromCoreBinding()
        }
    }

    func getFilms(view:UIView,limit:Int,offestNum:Int){
        NetworkService.request(url: URLs.Instance.getAllFilms(limit: limit, offest: offestNum), method: .get, view: view) { (data: MarvelFilms?) in
            if offestNum == 0 {
                self.fetchAllMovies = data?.data?.results ?? []
            }
            else{
                self.fetchAllMovies += data?.data?.results ?? []
            }
        }
    }
    
    func getFilmById(view:UIView,id:String){
        NetworkService.request(url: URLs.Instance.getFilmById(filmId: id), method: .get, view: view) { (data: MarvelFilms?) in
            self.filmDetails = data?.data?.results ?? []
        }
    }
    
    func saveFilmInCoreData(filmDescription:String,filmEndYear:Int,filmId:Int){
        CoreDataManager.saveToCoreData(filmDescription: filmDescription, filmEndYear: filmEndYear, filmId: filmId)
    }
    
    func fetchFilmFromCoreData(filmId:Int){
        filmsFromCoreData = CoreDataManager.fetchFromCoreData()
        for i in filmsFromCoreData{
            if filmId == i.id{
                filmFromCore = i
            }
        }
    }
    
    
}
