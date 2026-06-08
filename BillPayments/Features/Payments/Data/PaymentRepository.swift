protocol PaymentRepository {
    func pay(_ payment: Payment) async throws
}

final class FakePaymentRepository: PaymentRepository {
    private let network: MockNetwork

    init(network: MockNetwork) {
        self.network = network
    }

    func pay(_ payment: Payment) async throws {
        try await network.delay()
        try network.countAndMaybeFail()
    }
}
