//
//  DataAssembly.swift
//  data
//
//  Created by Nazim Asadov on 30.08.22.
//

import Foundation
import Swinject
import Alamofire
import domain
import RealmSwift

public class DataAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(Session.self) { _ in
            return AF
        }
        
        container.register(EventRemoteDataSourceProtocol.self) { r in
            return EventRemoteDataSource(networkProvider: r.resolve(Session.self)!)
        }
        
        container.register(EventRepoProtocol.self) { r in
            EventRepo(eventRemoteDataSource: r.resolve(EventRemoteDataSourceProtocol.self)!,
                      eventLocalDataSource: r.resolve(EventLocalDataSourceProtocol.self)!
            )
        }
        
        container.register(Realm.self) { _ in
            Realm.Configuration.defaultConfiguration = Realm.Configuration(
                schemaVersion: 1,
                migrationBlock: { migration, oldSchemaVersion in
                    // migration
                },
                deleteRealmIfMigrationNeeded: true
            )
            return try! Realm()
        }.inObjectScope(.container)
        
        container.register(EventLocalDataSourceProtocol.self) { r in
            EventLocalDataSource(realm: r.resolve(Realm.self)!)
        }.inObjectScope(.container)
    }
}
