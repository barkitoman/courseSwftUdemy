//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Juian Barco on 10/4/19.
//  Copyright © 2019 Juian Barco. All rights reserved.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {

    var category : Categories!
    var notes: Notes!
    var isEdit : Bool!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isEdit{
            let buttomSave  = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addNotes))
            navigationItem.rightBarButtonItem = buttomSave
        }else{
            let buttomEdit  = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(EditNote))
            navigationItem.rightBarButtonItem = buttomEdit
            titleTxt.text = notes.title
            descriptionTextView.text = notes.description_note
        }
    
    }

    @objc func addNotes(){
        let context = ConnectionCoreData().context()
        let entityNotes = NSEntityDescription.insertNewObject(forEntityName: "Notes", into: context) as! Notes
        entityNotes.id = UUID()
        entityNotes.id_category = category.id
        entityNotes.date_note = Date()
        entityNotes.title = titleTxt.text
        entityNotes.description_note = descriptionTextView.text
        //Generate relationship
        category.mutableSetValue(forKey: "relationToNotes").add(entityNotes)
        
        do{
            try context.save()
            navigationController?.popViewController(animated: true)
        }catch let error as NSError {
            print("there was a mistake", error.localizedDescription)
        }
    }
    
    @objc func EditNote(){
        let context = ConnectionCoreData().context()
        notes.setValue(titleTxt.text, forKey: "title")
        notes.setValue(descriptionTextView.text, forKey: "description_note")
        notes.setValue(Date(), forKey: "date_note")
        
        do{
            try context.save()
            print("edit")
            navigationController?.popViewController(animated: true)
        }catch let error as NSError {
            print("there was a mistake", error.localizedDescription)
        }
    }

}
