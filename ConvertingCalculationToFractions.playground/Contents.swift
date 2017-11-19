//: Playground - noun: a place where people can play

import Foundation

extension Double {
  // Only works to a maximum of 6 decimal places -- interesting
  func roundedTo(numberOfDecimalPlaces: Int) -> Double {
    let stringed = "1".appending(String(repeating: "0", count: numberOfDecimalPlaces))
    guard let multiplierAndDivisor = Double(stringed) else { fatalError() }
    return (self * multiplierAndDivisor).rounded() / multiplierAndDivisor
  }
}

private func convertDecimalToFraction(_ double: Double) -> String {
  switch double {
  case _ where (double > 0.0) && (double <= 0.25):
    return "1/4\""
  case _ where (double > 0.25) && (double <= 0.50):
    return "1/2\""
  case _ where (double > 0.50) && (double <= 0.75):
    return "3/4\""
  default:
    fatalError()
  }
}

private func pullNumbersFromRightOfDecimal(_ double: Double) -> Double {
  let stringDouble = String(double)
  guard let decimalIndex = stringDouble.index(of: ".") else { fatalError("Failed finding decimal index") }
  let stringDecimals = stringDouble[decimalIndex...]
  guard let trimmedDecimals = Double(stringDecimals) else { fatalError("Failed converting string to double") }
  return trimmedDecimals
}

func convertCalculationToMeasurement(_ calculation: Double) -> String {
  let calculationToTwoDecimalPlaces = calculation.roundedTo(numberOfDecimalPlaces: 2)
  let wholeInches = Int(calculationToTwoDecimalPlaces)
  let feet = Int(wholeInches / 12)
  var remainingInches = wholeInches - (feet * 12)
  let decimalOnly = pullNumbersFromRightOfDecimal(calculationToTwoDecimalPlaces)
  if decimalOnly > 0.75 {
    remainingInches += 1
    return "\(feet)' \(remainingInches)\""
  }
  let fraction = convertDecimalToFraction(decimalOnly)
  return "\(feet)' \(remainingInches)-\(fraction)"
}

let measurement = 73.124565476

print(convertCalculationToMeasurement(measurement))
