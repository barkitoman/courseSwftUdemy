//
//  ViewController.swift
//  Notes
//
//  Created by Juian Barco on 10/3/19.
//  Copyright © 2019 Juian Barco. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var categories = [Categories]()
    var fetchResultController : NSFetchedResultsController<Categories>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        showCategories()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
            case .delete:
                deleteCategory(indexPath: indexPath)
            default:
                break
        }
       
    }
    
    func deleteCategory(indexPath: IndexPath){
        let context = ConnectionCoreData().context()
        let delete = self.fetchResultController.object(at: indexPath)
        context.delete(delete)
        do{
            try context.save()
            print("delete")
        }catch let error as NSError {
            print("Error in delete", error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "notes", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "notes":
            if let id = tableView.indexPathForSelectedRow {
                let row = categories[id.row]
                let destination = segue.destination as! NotesTableViewController
                destination.category = row
            }
        default:
            break
        }
    }
    
    //MARK: SAVE IN ALERTCONTROLLER
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        let alert  = UIAlertController(title: "New Categori", message: "Add name for category", preferredStyle: .alert)
        alert.addTextField { (name) in
           name.placeholder = "Name category"
        }
        let accept = UIAlertAction(title: "Acept", style: .default, handler: {(action) in
            guard let name = alert.textFields?.first?.text else { return }
            let context = ConnectionCoreData().context()
            let entityCategory  = NSEntityDescription.insertNewObject(forEntityName: "Categories", into: context) as! Categories
            entityCategory.id = UUID()
            entityCategory.name = name
            
            do{
                try context.save()
                print("save")
            }catch let error as NSError {
                print("No save", error.localizedDescription)
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(accept)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: FETCHRESULTCONTROLLER
    func showCategories(){
        let context = ConnectionCoreData().context()
        let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
        //SELECT nombre FROM categories ORDER BY nombre DESC
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch()
            categories = fetchResultController.fetchedObjects!
        } catch let error as NSError {
            print("Error in show categories", error.localizedDescription)
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            self.tableView.reloadRows(at: [indexPath!], with: .fade)
        default:
            self.tableView.reloadData()
        }
        self.categories = controller.fetchedObjects as! [Categories]
    }
}

