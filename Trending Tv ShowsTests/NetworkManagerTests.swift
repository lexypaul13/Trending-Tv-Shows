//
//  NetworkManagerTests.swift
//  Trending Tv ShowsTests
//
//  Created by Alex Paul on 5/24/21.
//

import XCTest
@testable import Trending_Tv_Shows

class NetworkManagerTests: XCTestCase {
    // Test for empty image
    func test_download_nil_image(){
         let exp = expectation(description: "Image downloaded")
         var downloadedImage : UIImage?
         NetworkManger.shared.downloadImage(from: "") {  image in
           
             downloadedImage = image
               XCTAssertEqual(downloadedImage, nil)
             exp.fulfill()
        }
        wait(for: [exp], timeout: 10)
    }
    
    // Test for random image name
    func test_download_random_image()
    {
            let exp = expectation(description: "Image downloaded")
            var downloadedImage : UIImage?
            NetworkManger.shared.downloadImage(from: "asdfev") {  image in
              
                downloadedImage = image
                  XCTAssertEqual(downloadedImage, nil)
                exp.fulfill()
           }
           wait(for: [exp], timeout: 10)
    }
    
    
    
    

}
