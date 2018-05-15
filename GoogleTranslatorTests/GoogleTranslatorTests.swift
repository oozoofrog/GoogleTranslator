//
//  GoogleTranslatorTests.swift
//  GoogleTranslatorTests
//
//  Created by Kwanghoon Choi on 2018. 5. 15..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import XCTest
@testable import GoogleTranslator

class GoogleTranslatorTests: XCTestCase {
	
	var urlCreator: TranslateURLCreator!
	override func setUp() {
		super.setUp()
		urlCreator = TranslateURLCreator()
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func test_createURL() {
		let url = urlCreator.urlWith(targetURL: "http://unicode.org/reports/tr10/")
		XCTAssertNotNil(url)
		let source = URLComponents(url: URL(string: "https://translate.google.com/translate?sl=auto&tl=ko&js=y&prev=_t&hl=ko&ie=UTF-8&u=http%3A%2F%2Funicode.org%2Freports%2Ftr10%2F&edit-text=&act=url")!, resolvingAgainstBaseURL: true)
		let target = URLComponents(url: url!, resolvingAgainstBaseURL: true)
		XCTAssertEqual(source?.scheme, target?.scheme)
		XCTAssertEqual(source?.host, target?.host)
		XCTAssertEqual(source?.queryItems?.sorted(), target?.queryItems?.sorted())
	}
	
}

extension URLQueryItem: Comparable {
	public static func < (lhs: URLQueryItem, rhs: URLQueryItem) -> Bool {
		if lhs.name < rhs.name {
			return true
		}
		if lhs.name == rhs.name {
			return lhs.value ?? "" < rhs.value ?? ""
		}
		return false
	}
}
