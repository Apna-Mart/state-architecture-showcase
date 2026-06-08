import SwiftUI

struct RootView: View {
    let container: AppContainer

    @Environment(\.scenePhase) private var scenePhase
    @SceneStorage("navPath") private var navPathData: Data?
    @State private var toastMessage: String?
    @State private var toastDismissWork: Task<Void, Never>?
    @State private var didRestore = false

    private var language: String { container.settingsStore.language }

    var body: some View {
        content
            .id(language)
            .environment(container.router)
            .environment(\.locale, Locale(identifier: language))
            .environment(\.layoutDirection, language == "ar" ? .rightToLeft : .leftToRight)
            .tint(AppTheme.brandBlue)
            .preferredColorScheme(colorScheme)
            .overlay(alignment: .bottom) { toastOverlay }
            .task { await consumeEvents() }
            .onAppear(perform: restoreNavPathOnce)
            .onChange(of: container.router.path) { persistNavPath() }
            .onChange(of: isAuthenticated) { container.router.reset(to: []) }
            .onChange(of: scenePhase) { _, phase in handleScenePhase(phase) }
    }

    @ViewBuilder
    private var content: some View {
        if isAuthenticated {
            NavigationStack(path: Bindable(container.router).path) {
                HomeScreen(container: container)
                    .navigationDestination(for: Route.self, destination: destination)
            }
        } else {
            LoginScreen(container: container)
        }
    }

    @ViewBuilder
    private func destination(for route: Route) -> some View {
        switch route {
        case .login: LoginScreen(container: container)
        case .home: HomeScreen(container: container)
        case .search: SearchScreen(container: container)
        case .history: HistoryScreen(container: container)
        case .settings: SettingsScreen(container: container)
        case let .category(categoryId): CategoryScreen(container: container, categoryId: categoryId)
        case let .billFetch(billerId): BillFetchScreen(container: container, billerId: billerId)
        case let .billReview(billerId, account, amountPaise):
            BillReviewScreen(container: container, billerId: billerId, account: account, amountPaise: amountPaise)
        case let .receipt(paymentId): ReceiptScreen(container: container, paymentId: paymentId)
        }
    }

    @ViewBuilder
    private var toastOverlay: some View {
        if let toastMessage {
            Text(toastMessage)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: AppTheme.cornerRadiusMedium))
                .padding(.bottom, 24)
                .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }

    private var isAuthenticated: Bool {
        container.authStore.state.userIdOrNull != nil
    }

    private var colorScheme: ColorScheme? {
        switch container.settingsStore.state.themeMode {
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }

    private func consumeEvents() async {
        for await event in container.events.events {
            switch event {
            case let .paymentStarted(paymentId):
                container.router.reset(to: [.receipt(paymentId: paymentId)])
            case .paymentFailed:
                showToast(L10n.string("payment_failed_retry"))
            case .otpRejected:
                showToast(L10n.string("invalid_otp_message"))
            case .authFailed:
                showToast(L10n.string("something_went_wrong"))
            case .storageFailed:
                showToast(L10n.string("storage_failed_message"))
            }
        }
    }

    private func showToast(_ message: String) {
        toastDismissWork?.cancel()
        withAnimation { toastMessage = message }
        toastDismissWork = Task {
            try? await Task.sleep(for: .seconds(4))
            guard !Task.isCancelled else { return }
            withAnimation { toastMessage = nil }
        }
    }

    private func handleScenePhase(_ phase: ScenePhase) {
        guard phase == .active else { return }
        container.catalogStore.refreshIfStale()
        container.dueBillsStore.refreshIfStale()
        container.settingsStore.refreshLanguage()
    }

    private func restoreNavPathOnce() {
        guard !didRestore else { return }
        didRestore = true
        guard let navPathData else { return }
        container.router.restore(from: navPathData)
    }

    private func persistNavPath() {
        navPathData = try? container.router.serialized()
    }
}
