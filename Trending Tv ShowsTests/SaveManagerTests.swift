//
//  SaveManagerTests.swift
//  Trending Tv ShowsTests
//
//  Created by Alex Paul on 5/24/21.
//

import XCTest
@testable import Trending_Tv_Shows

class SaveManagerTests: XCTestCase {

    // Save Favourite Shows
    func test_save_show_in_favourites()
    {
        let show  : Show = Show(id: 1, overview: nil, voteCount: 1, name: nil, backdropPath: nil, voteAverage: nil, firstAirDate: nil)
        let result = SaveManger.save(favorites: [show])
        XCTAssert(result == nil, "Show saved succesfully")
        
    }
    
    // Add duplicate shows (Negative Case)
    func test_update_add_duplicate_show_in_favourites()
       {
             let show  : Show = Show(id: 1, overview: nil, voteCount: 1, name: nil, backdropPath: nil, voteAverage: nil, firstAirDate: nil)
           let action = SaveActionType.add
           SaveManger.updateWith(favorite: show, actionType: action) { error in
               
            XCTAssertEqual(error, ErroMessage.duplicateShow)
               
           }
           
       }
    
    // Remove show from favourites
    func test_update_remove_show_in_favourites()
    {
          let show  : Show = Show(id: 1, overview: nil, voteCount: 1, name: nil, backdropPath: nil, voteAverage: nil, firstAirDate: nil)
        let action = SaveActionType.remove
        SaveManger.updateWith(favorite: show, actionType: action) { error in
            
            XCTAssert(error == nil, "Removing show from favourites failed")
            
        }
        
    }
    
    // Remove shows from favourites (Negative Case)
    func test_update_remove_not_show_in_favourites()
    {
        let show  : Show = Show(id: 2, overview: nil, voteCount: 1, name: nil, backdropPath: nil, voteAverage: nil, firstAirDate: nil)
               let action = SaveActionType.remove
               SaveManger.updateWith(favorite: show, actionType: action) { error in
                   
                   XCTAssert(error == nil, "Removing show from favourites failed")
                   
               }
    }

}
