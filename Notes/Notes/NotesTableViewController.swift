//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Juian Barco on 10/4/19.
//  Copyright © 2019 Juian Barco. All rights reserved.
//

import UIKit
import CoreData

class NotesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var notes = [Notes]()
    var fetchResultController : NSFetchedResultsController<Notes>!
    var category : Categories!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = category.name
        let buttomAdd  = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNotes))
        navigationItem.rightBarButtonItem = buttomAdd
        showNotes()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteTableViewCell
        let note = notes[indexPath.row]
        cell.title.text = note.title
        let formatedDate = DateFormatter()
        formatedDate.dateFormat = "MMM dd, yyyy"
        let date = formatedDate.string(from: note.date_note!)
        cell.lbDate.text = "\(date)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditNote", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete ❌", handler: {(_, indexPath) in
            self.deleteNote(indexPath: indexPath)
        })
        let camera = UITableViewRowAction(style: .normal, title: "Picture 📷", handler: {(_, indexPath) in
           self.performSegue(withIdentifier: "Picture", sender: indexPath)
        })
        return [camera, delete]
    }
    //MARK: Add Notes
    @objc func addNotes(){
        performSegue(withIdentifier: "AddNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddNote":
            let destination = segue.destination as! AddNoteViewController
            destination.category = category
            destination.isEdit = false
        case "EditNote":
            if let id = tableView.indexPathForSelectedRow {
                let row = notes[id.row]
                let destination = segue.destination as! AddNoteViewController
                destination.notes = row
                destination.isEdit = true
            }
        case "Picture":
            let id = sender as! NSIndexPath
            let row = notes[id.row]
            let destination = segue.destination as! ImagesCollectionViewController
            destination.note = row
            
        default:
            break
        }
    }
    
    func deleteNote(indexPath: IndexPath){
        let context = ConnectionCoreData().context()
        //let category = notes[indexPath.row]
        let delete = self.fetchResultController.object(at: indexPath)
        context.delete(delete)
        do{
            try context.save()
            print("delete")
        }catch let error as NSError {
            print("Error in delete", error.localizedDescription)
        }
    }
    
    //MARK: FETCHRESULTCONTROLLER
    func showNotes(){
        let context = ConnectionCoreData().context()
        let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
        //SELECT nombre FROM Categories WHERE id_category  = 'id_cat' ORDER BY nombre ASC
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let id_cat = category.id
        fetchRequest.predicate = NSPredicate(format: "id_category == %@", id_cat! as CVarArg)
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch()
            notes = fetchResultController.fetchedObjects!
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
        self.notes = controller.fetchedObjects as! [Notes]
    }
}
