//
//  String+Ext.swift
//  
//
//  Created by Laurent B on 02/12/2020.
//

import Foundation


extension String.StringInterpolation {
	mutating func appendInterpolation(_ number: Double, specifier: String){
		appendLiteral(String(format:"%.3f", number))
	}
}


extension String {
	func groups(for regexPattern: String) -> [[String]] {
		do {
			let text = self
			let regex = try NSRegularExpression(pattern: regexPattern)
			let matches = regex.matches(in: text,
										range: NSRange(text.startIndex..., in: text))
			return matches.map { match in
				return (0..<match.numberOfRanges).map {
					let rangeBounds = match.range(at: $0)
					guard let range = Range(rangeBounds, in: text) else {
						return ""
					}
					return String(text[range])
				}
			}
		} catch let error {
			print("invalid regex: \(error.localizedDescription)")
			return []
		}
	}
	subscript(idx: Int) -> Character {
		Character(extendedGraphemeClusterLiteral: self[index(startIndex, offsetBy: idx)])
	}
	subscript(idx: Int) -> String {
		String(self[index(startIndex, offsetBy: idx)])
	}
}
