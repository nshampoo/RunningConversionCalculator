//
//  PaceCalculator.swift
//  RunningConversionCalculator
//
//  Created by Nicholas Shampoe on 3/29/23.
//

import Foundation

/// Typealieas to represent: Time, Distance, Pace
public typealias PaceCalculatedData = (time: TimeInterval, distance: Double, pace: Double)
/// The current session used to represent the session the user is in
/// In most instances I imagine we would have one session, this session holds onto the users typed in data
/// And can generate the output data
public class PaceCalculator {
    
    ///Represented as number of seconds
    private var time: TimeInterval?
    
    ///Represented as distance in KM
    private var distance: Double?
    
    ///Represented as Seconds/KM ~ time/distance
    private var pace: Double?
    
    ///Anything considered
    init(time: TimeInterval? = nil,
         distance: Double? = nil,
         pace: Double? = nil) throws {
        ///Not enough input, we need at least 2 of the 3 inputs to be nonOptional to do our calculations
        guard [time, distance, pace].compactMap( { $0 } ).count >= 2 else {
            throw SessionErrors.NotEnoughInputError
        }
        
        ///None of the input can be 0, otherwise the calculations would break
        guard time ?? 1 > 0, distance ?? 1 > 0, pace ?? 1 > 0 else {
            throw SessionErrors.NegativeInputError
        }
        
        ///If we have all 3 inputs then we must guarante no logical data errors
        if let time = time, let distance = distance, let pace = pace,
        calculatePace(time: time, distance: distance) != pace {
            throw SessionErrors.DataInconsistencyError
        }
        
        self.time = time
        self.distance = distance
        self.pace = pace
    }
    
    /// From a learning and software standpoint I want to include error handling.
    ///I'm sure its overengineering but lets have fun
    enum SessionErrors: Error {
        case NotEnoughInputError
        case NegativeInputError
        case DataInconsistencyError
    }
    
    func generateData() -> PaceCalculatedData {
        switch (time, distance, pace) {
        case (.some(let aTime), .some(let aDistance), .some(let aPace)):
            return (aTime, aDistance, aPace)
            
        case (nil, .some(let aDistance), .some(let aPace)):
            let calculatedTime = calculateTime(distance: aDistance, pace: aPace)
            return (calculatedTime, aDistance, aPace)
            
        case (.some(let aTime), nil, .some(let aPace)):
            let calculatedDistance = calculateDistance(time: aTime, pace: aPace)
            return (aTime, calculatedDistance, aPace)
            
        case (.some(let aTime), .some(let aDistance), nil):
            let calculatedPace = calculatePace(time: aTime, distance: aDistance)
            return (aTime, aDistance, calculatedPace)
        
        /// This block should never be hit, I should probably refactor this
        default:
            return (0,0,0)
        }
    }
    
    /// All based on one function:
    /// pace = time / distance

    private func calculatePace(time: TimeInterval, distance: Double) -> Double {
        return time / distance
    }
    
    private func calculateDistance(time: TimeInterval, pace: Double) -> Double {
        return time / pace
    }
    
    private func calculateTime(distance: Double, pace: Double) -> Double {
        return pace * distance
    }
}
