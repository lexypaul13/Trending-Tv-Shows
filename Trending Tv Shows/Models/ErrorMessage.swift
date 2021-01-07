//
//  ErrorMessage.swift
//  Trending Tv Shows
//
//  Created by Alex Paul on 1/7/21.
//

import Foundation
enum ErroMessage : String, Error{
    case invalidTvName = "This tvName created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."

}
