//
//  MovieService.swift
//  Movie
//
//  Created by Sunny on 2016/10/20.
//  Copyright © 2016年 devhubs. All rights reserved.
//

import Foundation
import CoreData

class MovieService{
    
    internal static func getMovies() -> NSFetchedResultsController<Movie>{
        let managedObjectContext = CoreDataStack().persistentContainer.viewContext
        let fetchedResultsController: NSFetchedResultsController<Movie>
        
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        let sort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            try fetchedResultsController.performFetch()
        }
        catch{
            fatalError("Error in fetching records")
        }
        
        return fetchedResultsController
        
    }

}
