//
//  TranslateURLCreator.swift
//  GoogleTranslator
//
//  Created by Kwanghoon Choi on 2018. 5. 15..
//  Copyright © 2018년 rollmind. All rights reserved.
//

import Foundation

struct TranslateURLCreator {
	let formURLString: String = "https://translate.google.com/translate?sl=auto&tl=ko&js=y&prev=_t&hl=ko&ie=UTF-8&edit-text=&act=url"
	func urlWith(targetURL: String?) -> URL? {
		guard let targetURL = targetURL else {
			return nil
		}
		guard let components = URLComponents(string: formURLString) else {
			return nil
		}
		var tempComponents = components
		var queryItems = tempComponents.queryItems ?? []
		queryItems.append(URLQueryItem(name: "u", value: targetURL))
		tempComponents.queryItems = queryItems
		return tempComponents.url
	}
}
