//
//  Movie+CoreDataClass.swift
//  Movie
//
//  Created by Sunny on 2016/10/20.
//  Copyright © 2016年 devhubs. All rights reserved.
//

import UIKit
import CoreData

@objc(Movie)
class Movie: NSManagedObject {
 //
    internal func getMovieInfo(title: String, context: NSManagedObjectContext) -> Movie?{
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", title)
        
        do{
            let results = try context.fetch(request)
            
            if results.count>0{
                return results.first
            }
            else{
                return nil
            }
        }
        catch{
            fatalError("Cannot get movie info")
        }
        return nil
    }
}
