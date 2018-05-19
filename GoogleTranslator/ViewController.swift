//
//  ViewController.swift
//  GoogleTranslator
//
//  Created by Kwanghoon Choi on 2018. 5. 15..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
	
	@IBOutlet weak var textField: UITextField!
	
	var translatedWebView: WKWebView!
	
	var originalWebView: WKWebView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let originalWebView = WKWebView(frame: self.view.bounds)
		originalWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.view.addSubview(originalWebView)
		self.originalWebView = originalWebView
		
		let translatedWebView = WKWebView(frame: self.view.bounds)
		translatedWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.view.addSubview(translatedWebView)
		self.translatedWebView = translatedWebView
		
		self.textField.text = "https://unicode.org/reports/tr10/"
		
		self.loadURL(urlString: self.textField.text)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func loadURL(urlString: String?) {
		guard let text = self.textField.text else {
			return
		}
		if let url = URL(string: text) {
			originalWebView.load(URLRequest(url: url))
		}
		
		if let url = TranslateURLCreator().urlWith(targetURL: text) {
			translatedWebView.load(URLRequest(url: url))
		}
	}
	
}


// MARK: - Segment 영역
extension ViewController {
	
	@IBAction func selectSegment(_ sender: UISegmentedControl) {
		let originalShow = sender.selectedSegmentIndex == 1
		UIView.animate(withDuration: 0.26, animations: {
			self.translatedWebView.alpha = originalShow ? 0.0 : 1.0
		})
	}
	
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		self.loadURL(urlString: textField.text)
		
		textField.resignFirstResponder()
		
		return true
	}
}
