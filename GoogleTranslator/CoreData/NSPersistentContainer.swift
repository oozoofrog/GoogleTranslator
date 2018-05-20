//
//  NSPersistentContainer.swift
//  GoogleTranslator
//
//  Created by Kwanghoon Choi on 2018. 5. 20..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import UIKit
import CoreData

extension NSPersistentContainer {
	
	static var shared: NSPersistentContainer {
		return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
	}
	
	func saveContextIfNeeded() {
		if viewContext.hasChanges {
			do {
				try viewContext.save()
			} catch {
				fatalError(error.localizedDescription)
			}
		}
	}
}
