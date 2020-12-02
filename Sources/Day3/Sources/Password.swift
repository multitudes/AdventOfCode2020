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
	let pos1: Int?
	let pos2: Int?

	var isValid: Bool {
		self.frequency ~= self.string.reduce(0) {
			$1 == self.char ? $0 + 1 : $0
		}
	}

	var isValidForNewPolicy: Bool {
		if let pos1 = pos1, let pos2 = pos2 {
			return (string[pos1-1] == char) != (string[pos2-1] == char)
		}
		return false
	}
	init(_ password: String) {
		let res = password.groups(for:"(\\d+)-(\\d+) ([a-z]). ([a-z]+)")[0]
		self.frequency = Int(res[1])!...Int(res[2])!
		self.char = Character(res[3])
		self.string = res[4]
		self.pos1 = Int(res[1])
		self.pos2 = Int(res[2])
	}
}

