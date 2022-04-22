//
//  GFError.swift
//  GHFollowers
//
//  Created by Brandon Rodriguez on 2/23/22.
//

import Foundation

enum GFError: String, Error {
    
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connected."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error adding user to favorites. Please try again."
    case alreadyInFavorites = "User is already in favorites."
    
}
