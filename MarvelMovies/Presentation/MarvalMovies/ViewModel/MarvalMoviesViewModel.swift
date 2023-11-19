//
//  MarvalMoviesViewModel.swift
//  MarvelMovies
//
//  Created by kariman eltawel on 17/11/2023.
//

import Foundation
import Alamofire
import NVActivityIndicatorView

protocol MarvalMoviesViewModelProtocol{
    var MarvelFilmsBinding : (() -> ())? { get set }
    var totalNumOfData:Int? { get set }
    var fetchAllMovies: [FilmsResult]? { get set}
    var filmByIdBinding: (() -> ())? {get set}
    var filmDetails: [FilmsResult]? {get set}
    var filmFromCore:FilmsDetailsResult?{get set}
    func getFilms(view:UIView,offestNum:Int)
    func getFilmById(view:UIView,id:String)
    func saveFilmInCoreData(filmDescription:String,filmEndYear:Int,filmId:Int)
    func fetchFilmFromCoreData(filmId:Int)
    func SearchForFilm(seaechWord:String)
    func pagination(indexPath:Int,view:UIView)
}

class MarvalMoviesViewModel:MarvalMoviesViewModelProtocol{
    var marvelMoviesUseCase:MarvelFilmsUseCaseProtocol = MarvelFilmsUseCase()
    var MarvelFilmsBinding : (() -> ())?
    var totalNumOfData:Int?
    var fetchAllMovies: [FilmsResult]?{
        didSet{
            MarvelFilmsBinding?()
        }
    }
    var savedFilms: [FilmsResult] = []
    var filmByIdBinding: (() -> ())?
    var filmDetails : [FilmsResult]?{
        didSet{
            filmByIdBinding?()
        }
    }
    var filmsFromCoreData : [FilmsDetailsResult] = []
    var filmFromCore:FilmsDetailsResult?
    var offsetNo: Int = 0
    
    func getFilms(view:UIView,offestNum:Int){
        marvelMoviesUseCase.fetchMarvelUseCae(view: view, limit: 15, offestNum: offestNum) { [unowned self] data in
            if offestNum == 0 {
                self.fetchAllMovies = data?.data?.results ?? []
            }
            else{
                self.fetchAllMovies! += data?.data?.results ?? []
            }
            self.totalNumOfData = data?.data?.total ?? 0
            savedFilms = fetchAllMovies ?? []
        }
    }
    
    func getFilmById(view:UIView,id:String){
        marvelMoviesUseCase.getFilmById(view: view, id: id) { data in
            self.filmDetails = data?.data?.results ?? []

        }
    }
    
    func saveFilmInCoreData(filmDescription:String,filmEndYear:Int,filmId:Int){
        marvelMoviesUseCase.saveInCoreData(filmDescription: filmDescription, filmEndYear: filmEndYear, filmId: filmId)
    }
    
    func fetchFilmFromCoreData(filmId:Int){
        filmsFromCoreData = marvelMoviesUseCase.fetchDataFromCore()
        for i in filmsFromCoreData{
            if filmId == i.id{
                filmFromCore = i
            }
        }
    }
    
    func SearchForFilm(seaechWord:String){
        fetchAllMovies = seaechWord.isEmpty ? savedFilms: fetchAllMovies?.filter{($0.title!.lowercased().contains(seaechWord.lowercased()))}
    }
    
    func pagination(indexPath:Int,view:UIView){
        guard  fetchAllMovies?.count != 0 else {
            // Data is empty or nil
            return
        }
        if indexPath == (fetchAllMovies?.count ?? 0) - 1 {
            if fetchAllMovies?.count ?? 0 < totalNumOfData ?? 0 {
                offsetNo += 1
                print("nnnnnnnnnn\(offsetNo)")
                getFilms(view: view,offestNum:offsetNo)
            }
        }
    }
    
}
