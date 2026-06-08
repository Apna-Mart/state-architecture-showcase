import Testing
import Foundation
@testable import BillPayments

struct RouterTests {

    @Test func startsAtRootWithEmptyPath() {
        #expect(Router().path.isEmpty)
    }

    @Test func pushAppendsToPath() {
        let router = Router()
        router.push(.search)
        #expect(router.path == [.search])
    }

    @Test func popNeverEmptiesBelowRoot() {
        let router = Router()
        router.push(.search)
        router.pop()
        router.pop()
        #expect(router.path.isEmpty)
    }

    @Test func resetReplacesPath() {
        let router = Router()
        router.push(.search)
        router.reset(to: [.receipt(paymentId: "pay-1")])
        #expect(router.path == [.receipt(paymentId: "pay-1")])
    }

    @Test func serializedPathRestoresAcrossInstances() throws {
        let router = Router()
        router.push(.category(categoryId: "electricity"))
        router.push(.billReview(billerId: "electricity-national", account: "12345", amountPaise: 5000))
        let fresh = Router()
        fresh.restore(from: try router.serialized())
        #expect(fresh.path == router.path)
    }

    @Test func restoreIgnoresCorruptPayload() {
        let router = Router()
        router.push(.search)
        router.restore(from: Data("not json".utf8))
        #expect(router.path == [.search])
    }
}
