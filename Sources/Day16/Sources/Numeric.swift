//
//  String+Ext.swift
//  
//
//  Created by Laurent B on 02/12/2020.
//

import Foundation

infix operator **

func **<I: BinaryInteger>(lhs: I, rhs: I) -> I {
	return I(pow(Double(lhs), Double(rhs)))
}

func **<I: BinaryInteger, F: BinaryFloatingPoint>(lhs: I, rhs: F) -> F {
	return F(pow(Double(lhs),Double(rhs)))
}

func **<I: BinaryInteger, F: BinaryFloatingPoint>(lhs: F, rhs: I) -> F {
	return F(pow(Double(lhs),Double(rhs)))
}

func **<F: BinaryFloatingPoint>(lhs: F, rhs: F) -> F {
	return F(pow(Double(lhs),Double(rhs)))
}
