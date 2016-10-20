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

    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let movie = Movie(context: managedObjectContext)
        let name = movie.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

