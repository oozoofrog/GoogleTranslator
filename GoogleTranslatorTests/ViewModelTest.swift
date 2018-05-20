//
//  ViewModelTest.swift
//  GoogleTranslatorTests
//
//  Created by Kwanghoon Choi on 2018. 5. 20..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import XCTest
@testable import GoogleTranslator

class ViewModelTest: XCTestCase {
	
	var viewModel: ViewModel!
	
	override func setUp() {
		super.setUp()
		viewModel = ViewModel()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func testBookmark() {
		print(viewModel.bookmarks)
	}
	
}
