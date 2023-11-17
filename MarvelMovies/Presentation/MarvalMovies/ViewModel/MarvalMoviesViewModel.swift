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
    }

