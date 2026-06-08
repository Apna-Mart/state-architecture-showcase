import SwiftUI

struct LoginScreen: View {
    let container: AppContainer
    @State private var model: LoginScreenModel

    init(container: AppContainer) {
        self.container = container
        _model = State(initialValue: LoginScreenModel(authStore: container.authStore))
    }

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Text(L10n.string("app_title"))
                .font(.title2)
            content
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(24)
    }

    @ViewBuilder
    private var content: some View {
        switch model.data {
        case let .phoneEntry(_, canSend, sending):
            PhoneEntryView(model: model, canSend: canSend, sending: sending)
        case let .otpEntry(phone, _, canVerify, verifying):
            OtpEntryView(model: model, phone: phone, canVerify: canVerify, verifying: verifying)
        }
    }
}

private struct PhoneEntryView: View {
    @Bindable var model: LoginScreenModel
    let canSend: Bool
    let sending: Bool

    var body: some View {
        VStack(spacing: 16) {
            TextField(L10n.string("mobile_number"), text: $model.phone)
                .keyboardType(.phonePad)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity)
            Button(action: model.sendOtp) {
                if sending {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                } else {
                    Text(L10n.string("send_otp"))
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(!canSend)
        }
    }
}

private struct OtpEntryView: View {
    @Bindable var model: LoginScreenModel
    let phone: String
    let canVerify: Bool
    let verifying: Bool

    var body: some View {
        VStack(spacing: 16) {
            Text(String.localizedStringWithFormat(L10n.string("otp_sent_to"), phone))
            TextField(L10n.string("enter_otp"), text: $model.otp)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: .infinity)
            Button(action: model.verifyOtp) {
                if verifying {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                } else {
                    Text(L10n.string("verify"))
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(!canVerify)
            Button(L10n.string("change_number"), action: model.changeNumber)
        }
    }
}
