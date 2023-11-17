//
//  MarvelFilmsViewController+Delegates.swift
//  MarvelMovies
//
//  Created by kariman eltawel on 17/11/2023.
//

import Foundation
import UIKit
import Kingfisher

extension MarvelFilmsViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        FilmsViewModel.fetchAllMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarvalFilmTableViewCell", for: indexPath) as! MarvalFilmTableViewCell
        viewCorner(view: cell.mainView,borderColor: UIColor.lightGray.cgColor)
        //------------main-------------------
        cell.filmTitle.text =   FilmsViewModel.fetchAllMovies[indexPath.row].title ?? "Not Found"
        cell.filmImg.kf.setImage(with:URL(string:FilmsViewModel.fetchAllMovies[indexPath.row].thumbnail?.path ?? ""),placeholder: UIImage(named: "notFound"))
        cell.releaseDate.text = "\(FilmsViewModel.fetchAllMovies[indexPath.row].startYear ?? 0)"
        cell.filmRate.text = FilmsViewModel.fetchAllMovies[indexPath.row].rating?.rawValue ?? "" == "" ? "No rating" : FilmsViewModel.fetchAllMovies[indexPath.row].rating?.rawValue
        if (FilmsViewModel.fetchAllMovies[indexPath.row].isSelected ?? false == false){
            cell.filmExpendedView.isHidden = true
        }
        //-----------------expanded-----------
        else{
            cell.filmExpendedView.isHidden = false
            FilmsViewModel.fetchFilmFromCoreData(filmId: FilmsViewModel.fetchAllMovies[indexPath.row].id ?? 0)
            FilmsViewModel.filmFromCoreBinding  = {  [unowned self] in
                DispatchQueue.main.async{ [unowned self] in
                    cell.filmDescription.text = FilmsViewModel.filmFromCore?.description ?? "Not Found"
                    cell.endYear.text =  "\(FilmsViewModel.filmFromCore?.endYear ?? 0000)"
                    filmsTable.reloadData()
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let count = FilmsViewModel.fetchAllMovies.count
        if FilmsViewModel.fetchAllMovies[indexPath.row].isSelected == true{
            for e in 0 ..< count {
                FilmsViewModel.fetchAllMovies[e].isSelected = false
            }
        }
        else{
            for e in 0 ..< count {
                FilmsViewModel.fetchAllMovies[e].isSelected = false
            }
            FilmsViewModel.fetchAllMovies[indexPath.row].isSelected = true
        }
        filmsTable.reloadData()
        //------------------------------------core data check----------------------
        if  FilmsViewModel.fetchAllMovies[indexPath.row].FirstPressed ?? false == false{
            FilmsViewModel.getFilmById(view: self.view, id: "\(FilmsViewModel.fetchAllMovies[indexPath.row].id ?? 0)")
    
            FilmsViewModel.filmByIdBinding = {
                DispatchQueue.main.async{ [unowned self] in
                    
                    FilmsViewModel.saveFilmInCoreData(filmDescription:  FilmsViewModel.filmDetails.first?.description ?? "NotFound", filmEndYear: FilmsViewModel.filmDetails.first?.endYear ?? 0, filmId: FilmsViewModel.filmDetails.first?.id ?? 0)
                    
                    FilmsViewModel.fetchAllMovies[indexPath.row].FirstPressed = true
                    filmsTable.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if searchField.text == "" {
            guard  FilmsViewModel.fetchAllMovies.count != 0 else {
                // Data is empty or nil
                return
            }
            if indexPath.row == (FilmsViewModel.fetchAllMovies.count) - 1 {
                if FilmsViewModel.fetchAllMovies.count < 14548 {
                    offsetNo += 1
                    print("nnnnnnnnnn\(offsetNo)")
                    FilmsViewModel.getFilms(view: self.view, limit: 15, offestNum:offsetNo)
                }
                
            }
        }
    }
    
}
