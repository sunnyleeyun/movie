//
//  MovieService.swift
//  Movie
//
//  Created by Andi Setiyadi on 9/2/16.
//  Copyright © 2016 devhubs. All rights reserved.


import Foundation
import CoreData

class MovieService {
    
    internal static func getMovies(managedObjectContext: NSManagedObjectContext) -> NSFetchedResultsController<Movie> {
        let fetchedResultController: NSFetchedResultsController<Movie>
        
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        let formatSort = NSSortDescriptor(key: "format", ascending: false)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [formatSort, titleSort]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: "format", cacheName: "myMovieCollection")
        
        do {
            try fetchedResultController.performFetch()
        }
        catch {
            fatalError("Error in fetching records")
        }
        
        return fetchedResultController
    }
}
