import Foundation
import SwiftData

@globalActor
actor DataActor {
    static let shared = DataActor()
    
    let container: ModelContainer
    private let context: ModelContext
    
    private init() {
        do {
            container = try ModelContainer(for: CachedUser.self)
            context = ModelContext(container)
        } catch {
            fatalError("Failed to create ModelContainer for CachedUser.")
        }
    }
    
    func save(user: CachedUser) {
        context.insert(user)
        try? context.save()
    }
    
    func fetchUsers() -> [CachedUser] {
        let descriptor = FetchDescriptor<CachedUser>(sortBy: [.init(\.id)])
        return (try? context.fetch(descriptor)) ?? []
    }
}
