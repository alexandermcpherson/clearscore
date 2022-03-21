//
//  NetworkServiceTests.swift
//  ClearScoreTests
//
//  Created by Alex McPherson on 18/03/2022.
//

import XCTest
@testable import ClearScore

class NetworkServiceTests: XCTestCase {

    private enum Constants {
        static let endpoint = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values"
    }
    var networkService: NetworkService!

    func testNetworkServiceEmptyUrlErrorWhenAnEmptyStringIsUsedForEndpoint() {
        let testData = CreditReport.self
        networkService = NetworkService(endpoint: "")
        networkService.getData(object: testData) { success, obj, error in
            guard let error = error as? NetworkError else { return }
            XCTAssertEqual(NetworkError.EmptyUrl.rawValue, error.rawValue)
        }
    }

    func testNetworkServiceNotConnectedErrorWhenNotConnectedToNetwork() {
        networkService = NetworkService(endpoint: Constants.endpoint)

        XCTAssertEqual(NetworkError.NotConnectedToNetwork.rawValue, "Not connected to network")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkService = nil
    }

}
