//
//  ViewController.swift
//  Movie
//
//  Created by Andi Setiyadi on 9/2/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var coreData = CoreDataStack()
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movie = Movie(context: coreData.persistentContainer.viewContext)
        let movies = movie.getMovieInfo(title: "X-Men", context: coreData.persistentContainer.viewContext)
        
        if movies != nil{
            print(movie.format)
        }
        else{
            print("No movie info is found")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

