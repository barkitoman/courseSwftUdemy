//
//  ViewController.swift
//  AutoIncrementId
//
//  Created by Jorge M. B. on 25/10/18.
//  Copyright © 2018 Jorge M. B. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func guardar(_ sender: Any) {
       let entityPersonas = NSEntityDescription.insertNewObject(forEntityName: "Personas", into: contexto) as! Personas
        
        // SELECT * FROM personas ORDER BY id desc LIMIT 1
        let fetchRequest : NSFetchRequest<Personas> = Personas.fetchRequest()
        let orderById = NSSortDescriptor(key: "id", ascending: false)
        fetchRequest.sortDescriptors = [orderById]
        fetchRequest.fetchLimit = 1
        
        do {
            let idResult = try contexto.fetch(fetchRequest)
            let id = idResult[0].id + 1
            entityPersonas.id = id
        } catch _ {
            
        }
        
        do {
            try contexto.save()
            print("guardo")
        } catch _ {
            
        }
    
    }
    
    @IBAction func mostrar(_ sender: Any) {
        let fetchRequest : NSFetchRequest<Personas> = Personas.fetchRequest()
        do {
            let resultado = try contexto.fetch(fetchRequest)
            print("Numero de registros: \(resultado.count)")
            for res in resultado as [NSManagedObject] {
                let id = res.value(forKey: "id")
                print("ID: \(id!)")
            }
        } catch _ {
            
        }
    }
    
    @IBAction func eliminar(_ sender: Any) {

        let fetchRequest: NSFetchRequest<Personas> = Personas.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == 4")
        do {
            let resultado = try contexto.fetch(fetchRequest)
            for res in resultado {
                contexto.delete(res)
            }
            try contexto.save()
            print("elimino")
        } catch _ {
            
        }
    }
}

