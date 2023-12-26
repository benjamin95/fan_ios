//
//  Date.swift
//  FranceAntiNuisible
//
//  Created by Benjamin Truillet on 22/08/2023.
//

import Foundation

func formatTimestampInFrench(timestampString: String) -> String? {
    guard let timestamp = TimeInterval(timestampString) else {
        return nil
    }
    let date = Date(timeIntervalSince1970: timestamp)
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "fr_FR")
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    
    return dateFormatter.string(from: date)
}

func convertTimestampStringToDate(timestampString: String) -> Date? {
    guard let timestamp = TimeInterval(timestampString) else {
        return nil
    }
    return Date(timeIntervalSince1970: timestamp)
}

func formatDateInFrench(dateString: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    
    guard let date = inputFormatter.date(from: dateString) else {
        return nil
    }
    
    let outputFormatter = DateFormatter()
    outputFormatter.locale = Locale(identifier: "fr_FR")
    outputFormatter.dateStyle = .medium
    outputFormatter.timeStyle = .none
    
    return outputFormatter.string(from: date)
}

