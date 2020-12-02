//
//  Password.swift
//  
//
//  Created by Laurent B on 02/12/2020.
//

import Foundation

struct Password {
	let frequency: ClosedRange<Int>
	let char: Character
	let string: String
	let pos1: Int
	let pos2: Int

	var isValid: Bool {
		self.frequency ~= self.string.reduce(0) {
			$1 == self.char ? $0 + 1 : $0
		}
	}

	var isValidForNewPolicy: Bool {(string[pos1-1] == char) != (string[pos2-1] == char)}

	init?(_ password: String) {
		let res = password.getCapturedGroupsFrom(regexPattern:"(\\d+)-(\\d+) ([a-z]). ([a-z]+)")
		if let res = res {
			self.frequency = Int(res[0])!...Int(res[1])!
			self.char = Character(res[2])
			self.string = res[3]
			self.pos1 = Int(res[0])!
			self.pos2 = Int(res[1])!
		} else { return nil }

	}
}

