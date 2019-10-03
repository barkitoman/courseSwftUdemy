//
//  TableViewController.swift
//  PersistenciaCD_BD
//
//  Created by Juian Barco on 10/3/19.
//  Copyright © 2019 Juian Barco. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var students = [Students]()
    
    func context() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getStudents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let student = students[indexPath.row]
        cell.textLabel?.text = student.name
        cell.detailTextLabel?.text = "\(String(describing: student.address!)) - \(student.age)"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let cont = context()
        let student = students[indexPath.row]
        if editingStyle == .delete {
            cont.delete(student)
            do{
                try cont.save()
                
            }catch let error as NSError {
                print("There was an error in delete fetch", error.localizedDescription)
            }
        }
        getStudents()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "edit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "edit":
            if let id = tableView.indexPathForSelectedRow {
                let row = students[id.row]
                let destination = segue.destination as! EditViewController
                destination.studentEdit = row
            }
        default:
            break
        }
    }
    
    func getStudents(){
        let cont  = context()
        let fetchRequest : NSFetchRequest<Students> = Students.fetchRequest()
        
        do{
            students = try cont.fetch(fetchRequest)
        }catch let error as NSError {
            print("There was an error displaying the data", error.localizedDescription)
        }
    }

}
