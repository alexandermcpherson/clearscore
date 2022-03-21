//
//  NetworkMonitorTests.swift
//  ClearScoreTests
//
//  Created by Alex McPherson on 16/03/2022.
//

import XCTest

@testable import ClearScore

// Given

// When

// Then

class NetworkMonitorTests: XCTestCase {

    override func setUpWithError() throws {
        NetworkMonitor.shared.startMonitoringNetwork()
    }

    func testNetworkMonitorIsMonitoringConnectivity() {
        let isMonitoring = NetworkMonitor.shared.isMonitoring
        XCTAssertTrue(isMonitoring)
    }

    func testNetworkMonitorIsConnected() {
        let isConnected = NetworkMonitor.shared.isReachable
        XCTAssertTrue(isConnected)
    }

    func testNetworkMonitorIsNotAnExpensiveConnection() {
        let isExpensive = NetworkMonitor.shared.isExpensive
        XCTAssertFalse(isExpensive)
    }
}
