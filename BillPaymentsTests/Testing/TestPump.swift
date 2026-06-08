import Foundation

@MainActor
func waitUntil(_ condition: () -> Bool, maxIterations: Int = 2000) async {
    for _ in 0..<maxIterations {
        if condition() { return }
        await Task.yield()
        try? await Task.sleep(for: .milliseconds(1))
    }
}
