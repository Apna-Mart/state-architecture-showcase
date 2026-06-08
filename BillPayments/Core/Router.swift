import Foundation
import Observation

@Observable
final class Router {
    var path: [Route] = []

    func push(_ route: Route) { path.append(route) }
    func pop() { _ = path.popLast() }
    func reset(to routes: [Route]) { path = routes }

    func serialized() throws -> Data { try JSONEncoder().encode(path) }

    func restore(from data: Data) {
        guard let routes = try? JSONDecoder().decode([Route].self, from: data) else { return }
        path = routes
    }
}
