import Foundation

protocol PaymentHistoryRepository {
    func restore(userId: String) -> Payments
    func persist(userId: String, value: Payments) async throws
}

private struct PaymentDto: Codable {
    let id: String
    let billerId: String
    let billerName: String
    let categoryId: String
    let account: String
    let amountPaise: Int64
    let paidAtUtc: Double
    let status: String
}

private struct PaymentsDto: Codable {
    let nextId: Int
    let items: [PaymentDto]
}

final class StoredPaymentHistoryRepository: PaymentHistoryRepository {
    private let store: KeyValueStore

    init(store: KeyValueStore) {
        self.store = store
    }

    func restore(userId: String) -> Payments {
        guard let raw = store.read(keyFor(userId)),
              let data = raw.data(using: .utf8),
              let dto = try? JSONDecoder().decode(PaymentsDto.self, from: data)
        else { return .empty }
        return Payments(items: dto.items.map(decode), nextId: dto.nextId)
    }

    func persist(userId: String, value: Payments) async throws {
        let dto = PaymentsDto(
            nextId: value.nextId,
            items: value.items.map {
                PaymentDto(
                    id: $0.id,
                    billerId: $0.billerId,
                    billerName: $0.billerName,
                    categoryId: $0.categoryId,
                    account: $0.account,
                    amountPaise: $0.amountPaise,
                    paidAtUtc: $0.paidAtUtc.timeIntervalSince1970,
                    status: $0.status.rawValue
                )
            }
        )
        let data = try JSONEncoder().encode(dto)
        guard let raw = String(data: data, encoding: .utf8) else { throw StorageError() }
        try await store.write(keyFor(userId), raw)
    }

    private func decode(_ dto: PaymentDto) -> Payment {
        let status = PaymentStatus(rawValue: dto.status) ?? .failed
        return Payment(
            id: dto.id,
            billerId: dto.billerId,
            billerName: dto.billerName,
            categoryId: dto.categoryId,
            account: dto.account,
            amountPaise: dto.amountPaise,
            paidAtUtc: Date(timeIntervalSince1970: dto.paidAtUtc),
            status: status == .processing ? .failed : status
        )
    }

    private func keyFor(_ userId: String) -> String { "payments.\(userId)" }
}
