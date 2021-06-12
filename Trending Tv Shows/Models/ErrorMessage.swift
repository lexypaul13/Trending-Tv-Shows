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
    case invalidURL = "Not a valid URL"
    case duplicateShow = "This show already exist"
    case saveFailure = "There was an issue saving this Tv Show"
    case error = "Error"
    case enterSubject = "Enter the subject"
    case  enterMessage = "Enter the message"
    case noEmailAPP = "Application is not able to send an email"
}
