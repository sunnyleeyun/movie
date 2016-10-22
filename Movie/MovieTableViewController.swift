//
//  MovieTableViewController.swift
//  Movie
//
//  Created by Andi Setiyadi on 9/2/16.
//  Copyright © 2016 devhubs. All rights reserved.
//

import UIKit
import CoreData

class MovieTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var fetchedResultController: NSFetchedResultsController<Movie>!
    lazy var coreData = CoreDataStack()
    var movieToDelete: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchedResultController.sections {
            return sections.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultController.sections {
            let currentSection = sections[section]
            return currentSection.numberOfObjects
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell

        let movie = fetchedResultController.object(at: indexPath)
        cell.configureCell(movie: movie)

        return cell
    }
    
    @IBAction func updateRatingAction(_ sender: UIBarButtonItem) {
        let managedObjectContext = coreData.persistentContainer.viewContext
        
        let batchUpdateRequest = NSBatchUpdateRequest(entityName: "Moive")
        batchUpdateRequest.propertiesToUpdate = ["userRating": 5]
        batchUpdateRequest.resultType = .updatedObjectIDsResultType
        
        do{
            let batchUpdateResult = try managedObjectContext.execute(batchUpdateRequest) as? NSBatchUpdateResult
            print("Batch update on: \(batchUpdateResult!.result!)")
        }
        catch{
            fatalError("Error performing batch update")
        }
    }
    
    // MARK: Private function
    
    private func loadData() {
        fetchedResultController = MovieService.getMovies(managedObjectContext: self.coreData.persistentContainer.viewContext)
        fetchedResultController.delegate = self
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let managedObjectContext = coreData.persistentContainer.viewContext
        
        if editingStyle == .delete {
            movieToDelete = fetchedResultController.object(at: indexPath)
            
            let confirmDeleteAlertController = UIAlertController(title: "Remove Movie", message: "Are you sure you would like to delete \"\(movieToDelete!.title!)\" from your movie library?", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default, handler: { [weak self] (action: UIAlertAction) -> Void in
                managedObjectContext.delete((self?.movieToDelete!)!)
                self?.coreData.saveContext()
                self?.movieToDelete = nil
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { [weak self] (action: UIAlertAction) -> Void in
                self?.movieToDelete = nil
            })
            
            confirmDeleteAlertController.addAction(deleteAction)
            confirmDeleteAlertController.addAction(cancelAction)
            
            present(confirmDeleteAlertController, animated: true, completion: nil)
            
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case NSFetchedResultsChangeType.delete:
            print("NSFetchedResultsChangeType.Delete detected")
            if let deleteIndexPath = indexPath {
                tableView.deleteRows(at: [deleteIndexPath], with: UITableViewRowAnimation.fade)
            }
        case NSFetchedResultsChangeType.insert:
            print("NSFetchedResultsChangeType.Insert detected")
        case NSFetchedResultsChangeType.move:
            print("NSFetchedResultsChangeType.Move detected")
        case NSFetchedResultsChangeType.update:
            print("NSFetchedResultsChangeType.Update detected")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
