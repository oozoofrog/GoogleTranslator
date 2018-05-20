//
//  ViewController.swift
//  GoogleTranslator
//
//  Created by Kwanghoon Choi on 2018. 5. 15..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, Viewer {
	
	@IBOutlet weak var textField: UITextField!
	
	var translatedWebView: WKWebView!
	
	var originalWebView: WKWebView!
	
	var notification: NSObjectProtocol?
	
	lazy var viewModel: ViewModel = ViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let originalWebView = WKWebView(frame: self.view.bounds)
		originalWebView.scrollView.delegate = self
		originalWebView.navigationDelegate = self
		originalWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.view.addSubview(originalWebView)
		self.originalWebView = originalWebView
		
		let translatedWebView = WKWebView(frame: self.view.bounds)
		translatedWebView.scrollView.delegate = self
		translatedWebView.navigationDelegate = self
		translatedWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.view.addSubview(translatedWebView)
		self.translatedWebView = translatedWebView
		
		self.textField.text = UserDefaults.standard.value(forKey: "URL") as? String ?? "https://unicode.org/reports/tr10/"
		
		self.loadURL(urlString: self.textField.text)
		
		self.notification = NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationWillResignActive, object: nil, queue: .main) { [weak self] (_) in
			guard let original = self?.originalWebView, let translated = self?.translatedWebView else {
				return
			}
			UserDefaults.standard.setValue(original.scrollView.contentOffset.y, forKey: "OriginalOffset")
			UserDefaults.standard.setValue(translated.scrollView.contentOffset.y, forKey: "TranslatedOffset")
			UserDefaults.standard.synchronize()
		}
	}
	
	deinit {
		if let notification = self.notification {
			NotificationCenter.default.removeObserver(notification)
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	var urlString: String {
		return self.textField.text ?? ""
	}
	var originalURL: URL? {
		return URL(string: urlString)
	}
	
	var translateURL: URL? {
		return TranslateURLCreator().urlWith(targetURL: urlString)
	}
	
	func loadURL(urlString: String?) {
		
		if let url = originalURL {
			originalWebView.load(URLRequest(url: url))
		}
		
		if let url = translateURL {
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

extension ViewController: WKNavigationDelegate {
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		if webView == originalWebView {
			UserDefaults.standard.setValue(textField.text, forKey: "URL")
			UserDefaults.standard.synchronize()
		}
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
			guard let original = self?.originalWebView, let translated = self?.translatedWebView else {
				return
			}
			switch webView {
			case original:
				if let offset = UserDefaults.standard.value(forKey: "OriginalOffset") as? CGFloat {
					webView.scrollView.contentOffset = CGPoint(x: 0, y: offset)
				}
			case translated:
				if let offset = UserDefaults.standard.value(forKey: "TranslatedOffset") as? CGFloat {
					webView.scrollView.contentOffset = CGPoint(x: 0, y: offset)
				}
			default:
				break
			}
		}
	}
}

extension ViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		switch scrollView {
		case self.translatedWebView.scrollView:
			self.originalWebView.scrollView.contentOffset = scrollView.contentOffset
		default:
			self.translatedWebView.scrollView.contentOffset = scrollView.contentOffset
		}
	}
}
