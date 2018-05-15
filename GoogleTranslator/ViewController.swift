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
	
	var webView: WKWebView? {
		return self.view.subviews.first as? WKWebView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let webView = WKWebView(frame: self.view.bounds)
		self.view.addSubview(webView)
		
		if let url = TranslateURLCreator().urlWith(targetURL: "http://unicode.org/reports/tr10/") {
			webView.load(URLRequest(url: url))
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

extension ViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		let url = TranslateURLCreator().urlWith(targetURL: textField.text)
		guard let requestURL = url else {
			return false
		}
		textField.resignFirstResponder()
		webView?.load(URLRequest(url: requestURL))
		return true
	}
}
