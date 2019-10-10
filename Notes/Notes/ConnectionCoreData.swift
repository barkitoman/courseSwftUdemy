//
//  ConnectionCoreData.swift
//  Notes
//
//  Created by Juian Barco on 10/4/19.
//  Copyright © 2019 Juian Barco. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ConnectionCoreData {
    func context() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
}
