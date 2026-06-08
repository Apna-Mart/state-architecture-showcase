import SwiftUI

struct BillFetchScreen: View {
    let container: AppContainer
    let billerId: String
    @State private var model: BillFetchScreenModel

    init(container: AppContainer, billerId: String) {
        self.container = container
        self.billerId = billerId
        _model = State(initialValue: BillFetchScreenModel(catalogStore: container.catalogStore, billerId: billerId))
    }

    var body: some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }

    private var title: String {
        if case let .form(billerName, _, _) = model.data { return billerName }
        return L10n.string("bill_details")
    }

    @ViewBuilder
    private var content: some View {
        switch model.data {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .error:
            Text(L10n.string("something_went_wrong"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case let .form(_, inputs, submit):
            FetchFormView(model: model, inputs: inputs, submit: submit, router: container.router)
        }
    }
}

private struct FetchFormView: View {
    @Bindable var model: BillFetchScreenModel
    let inputs: FetchInputsData
    let submit: FetchSubmitData
    let router: Router

    var body: some View {
        VStack(spacing: 12) {
            ForEach(inputs.fields, id: \.key) { field in
                TextField(field.hint, text: fieldBinding(field))
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: .infinity)
            }
            if inputs.showAmount {
                TextField(L10n.string("enter_amount"), text: $model.amountText)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: .infinity)
            }
            Button(action: submitTapped) {
                Text(submitLabel)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(submit.reviewRoute == nil)
            Spacer()
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }

    private var submitLabel: String {
        switch submit.action {
        case .fetchBill: L10n.string("fetch_bill")
        case .continueToReview: L10n.string("continue_label")
        }
    }

    private func fieldBinding(_ field: FetchFieldData) -> Binding<String> {
        Binding(
            get: { model.values[field.key] ?? "" },
            set: { model.editField(key: field.key, value: $0) }
        )
    }

    private func submitTapped() {
        guard let route = submit.reviewRoute else { return }
        router.push(route)
    }
}
