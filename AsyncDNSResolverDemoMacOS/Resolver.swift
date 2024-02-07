//
//  Resolver.swift
//  AsyncDNSResolverDemoMacOS
//
//  Created by Alex on 07/02/2024.
//

import SwiftUI
import AsyncDNSResolver

class Resolver {
    static var shared = Resolver()
    
    @Published var ips: [String] = []

    private let resolver: AsyncDNSResolver

    // Initialize a resolver
    private init() {
        do {
            resolver = try AsyncDNSResolver()
        } catch {
            print("Error:", error)
            fatalError("AsyncDNSResolver throwed!")
        }
    }
    
    func resolve(_ name: String) async {
        let records: [ARecord]
        do {
            records = try await resolver.queryA(name: name)
        } catch {
            print("Error:", error)
            fatalError("DNS query throwed!")
        }
        ips = records.map { record in
            "\(record.address)"
        }
    }
    
}
