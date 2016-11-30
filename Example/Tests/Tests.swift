import UIKit
import XCTest
import SuperMarket

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEverPostAppInfo() {
        
        let description = expectation(description: "Found information of everPost.")
        SuperMarket.findAppWithName("everPost", developer: nil, country: nil, offset: 0, limit: 0, progress: { (progress) in
            
            
        }) { (result) in
            
            switch result {
            case .success(items: let items) :
                XCTAssertEqual(items.count, 1)
                description.fulfill()
            case .failure(error: let error) :
                XCTFail(error.localizedDescription)
            }
        }
        
        self.waitForExpectations(timeout: 100) { (error) in
            
        }
    }
    
    func testEverPostAppInfoWithBundle() {
        
        let description = expectation(description: "Found information of everPost.")
        SuperMarket.findAppWithTerms(nil, bundleId: "com.jagaimopotato.everpost", appId:nil,  country: "jp", progress: { (progress) in
            
        }) { (result) in
            
            switch result {
            case .success(items: let items) :
                XCTAssertEqual(items.count, 1, "")
                description.fulfill()
            case .failure(error: let error) :
                XCTFail(error.localizedDescription)
            }
        }
        
        self.waitForExpectations(timeout: 100) { (error) in
            
        }
        
    }
    
    func testEverPostAppInfoWithItemIt() {
        
        let description = expectation(description: "Found information of everPost.")
        SuperMarket.findAppWithTerms(nil, bundleId: nil, appId:"595116637",  country: "jp", progress: { (progress) in
            
        }) { (result) in
            
            switch result {
            case .success(items: let items) :
                XCTAssertEqual(items.count, 1, "")
                description.fulfill()
            case .failure(error: let error) :
                XCTFail(error.localizedDescription)
            }
        }
        
        self.waitForExpectations(timeout: 100) { (error) in
            
        }
        
    }
    
}
