//
//  NetworkMonitor.swift
//  ClearScore
//
//  Created by Alex McPherson on 14/03/2022.
//

import Foundation
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()

    // MARK: - Properties
    private let networkMonitor = NWPathMonitor()
    var isReachable = false
    var isExpensive = false
    var isMonitoring = false

    // MARK: - Init
    private init() {}

    // MARK: - Methods
    func startMonitoringNetwork() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.isReachable = true
            } else {
                self?.isReachable = false
            }

            if path.isExpensive {
                self?.isExpensive = true
            }
        }

        let queue = DispatchQueue(label: "MonitorNetworking")
        networkMonitor.start(queue: queue)
        isMonitoring = true
    }

    func stopMonitoringNetwork() {
        networkMonitor.cancel()
        isMonitoring = false
    }
}
