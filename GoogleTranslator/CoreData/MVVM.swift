//
//  ViewModelable.swift
//  GoogleTranslator
//
//  Created by Kwanghoon Choi on 2018. 5. 20..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import UIKit
import CoreData

protocol ViewModelable {
}

protocol Viewer {
	associatedtype ViewModel: ViewModelable
	var viewModel: ViewModel { get }
}
