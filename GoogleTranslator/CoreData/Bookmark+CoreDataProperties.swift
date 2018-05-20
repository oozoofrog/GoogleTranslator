//
//  Bookmark+CoreDataProperties.swift
//  GoogleTranslator
//
//  Created by Kwanghoon Choi on 2018. 5. 20..
//  Copyright © 2018년 rollmind. All rights reserved.
//
//

import Foundation
import CoreData


extension Bookmark {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmark> {
		return NSFetchRequest<Bookmark>(entityName: "Bookmark")
	}
	
	@NSManaged public var name: String?
	@NSManaged public var sourceURL: URL?
	@NSManaged public var translatedURL: URL? {
		return TranslateURLCreator().urlWith(targetURL: sourceURL?.absoluteString)
	}
	@NSManaged public var bookmarks: Bookmarks?
	
}
