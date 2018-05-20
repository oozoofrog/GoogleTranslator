//
//  CoreDataTests.swift
//  GoogleTranslatorTests
//
//  Created by Kwanghoon Choi on 2018. 5. 20..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import XCTest
import CoreData
@testable import GoogleTranslator

class CoreDataTests: XCTestCase {
	
	var persistentContainer: NSPersistentContainer!
	var managedObjectContext: NSManagedObjectContext!
	
	override func setUp() {
		super.setUp()
		persistentContainer = NSPersistentContainer(name: "Bookmark")
		managedObjectContext = persistentContainer.viewContext
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testExample() {
		let bookmark = Bookmark(context: managedObjectContext)
		bookmark.name = "First"
		bookmark.sourceURL = "https://unicode.org"
	}
	
}
