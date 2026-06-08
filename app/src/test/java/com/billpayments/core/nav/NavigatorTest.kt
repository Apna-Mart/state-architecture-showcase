package com.billpayments.core.nav

import org.junit.Assert.assertEquals
import org.junit.Test

class NavigatorTest {

    @Test
    fun startsAtGivenRoot() {
        assertEquals(listOf<AppNavKey>(LoginKey), Navigator(LoginKey).backStack.toList())
    }

    @Test
    fun goToPushes() {
        val navigator = Navigator(HomeKey)
        navigator.goTo(SearchKey)
        assertEquals(listOf<AppNavKey>(HomeKey, SearchKey), navigator.backStack.toList())
    }

    @Test
    fun backPopsButNeverEmptiesStack() {
        val navigator = Navigator(HomeKey)
        navigator.goTo(SearchKey)
        navigator.back()
        navigator.back()
        assertEquals(listOf<AppNavKey>(HomeKey), navigator.backStack.toList())
    }

    @Test
    fun setStackReplacesEverything() {
        val navigator = Navigator(LoginKey)
        navigator.goTo(SearchKey)
        navigator.setStack(HomeKey, ReceiptKey("pay-1"))
        assertEquals(listOf(HomeKey, ReceiptKey("pay-1")), navigator.backStack.toList())
    }

    @Test
    fun serializedStackRestoresAcrossInstances() {
        val navigator = Navigator(HomeKey)
        navigator.goTo(CategoryKey("electricity"))
        navigator.goTo(BillReviewKey("electricity-national", "12345", 5000L))
        val fresh = Navigator(HomeKey)
        fresh.restore(navigator.serialized())
        assertEquals(navigator.backStack.toList(), fresh.backStack.toList())
    }

    @Test
    fun restoreIgnoresCorruptPayload() {
        val navigator = Navigator(HomeKey)
        navigator.restore("not json")
        assertEquals(listOf<AppNavKey>(HomeKey), navigator.backStack.toList())
    }
}
