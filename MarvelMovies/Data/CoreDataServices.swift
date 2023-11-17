//
//  CoreDataServices.swift
//  MarvelMovies
//
//  Created by kariman eltawel on 17/11/2023.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager
{
    static var context : NSManagedObjectContext?
    static var appDelegate : AppDelegate?
    
    
    static func saveToCoreData(filmDescription : String , filmEndYear : Int , filmId: Int)
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        context = appDelegate?.persistentContainer.viewContext
        
        guard let myContext = context else{return}
        
        let entity = NSEntityDescription.entity(forEntityName: "FilmDetails", in: myContext)
        
        guard let myEntity = entity else{return}
        
        do{
 
            let FilmDescription = NSManagedObject(entity: myEntity, insertInto: myContext)
            FilmDescription.setValue(filmDescription, forKey: "filmDescription")
            FilmDescription.setValue(filmEndYear, forKey: "filmEndYear")
            FilmDescription.setValue(filmId, forKey: "filmId")
            
            print("Saved Successfully")
            
            try myContext.save()
            
        }catch let error{
            
            print(error.localizedDescription)
        }
    }
    
    static func fetchFromCoreData() ->[FilmsDetailsResult]
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "FilmDetails")
        
        var arrayOfFilmDetails : [FilmsDetailsResult] = []
        do{
 
            let filmSelected = try context?.fetch(fetch)
            
            guard let film = filmSelected else{return []}
            
            for item in film
            {
                let filmDescription = item.value(forKey: "filmDescription")
                let filmEndYear = item.value(forKey: "filmEndYear")
                let filmId = item.value(forKey: "filmId")
                
                let film = FilmsDetailsResult(id: filmId as? Int, description: filmDescription as? String,endYear: filmEndYear as? Int)
                arrayOfFilmDetails.append(film)
            }
            
        }catch let error
        {
            print(error.localizedDescription)
        }
        return arrayOfFilmDetails
    }
}
