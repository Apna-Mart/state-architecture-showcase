package com.billpayments.l10n

import java.io.File
import javax.xml.parsers.DocumentBuilderFactory
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class L10nGuardTest {

    private fun resBase(): File {
        val cwd = File(System.getProperty("user.dir"))
        val direct = File(cwd, "src/main/res")
        if (direct.exists()) return direct
        return File(cwd, "app/src/main/res")
    }

    private fun keysOf(path: String): Set<String> {
        val file = File(resBase(), path)
        assertTrue("missing ${file.absolutePath}", file.exists())
        val doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(file)
        val strings = doc.getElementsByTagName("string")
        val plurals = doc.getElementsByTagName("plurals")
        val keys = mutableSetOf<String>()
        for (i in 0 until strings.length) keys += strings.item(i).attributes.getNamedItem("name").nodeValue
        for (i in 0 until plurals.length) keys += "plurals:" + plurals.item(i).attributes.getNamedItem("name").nodeValue
        return keys
    }

    @Test
    fun allLocalesDefineIdenticalKeys() {
        val en = keysOf("values/strings.xml")
        val hi = keysOf("values-hi/strings.xml")
        val ar = keysOf("values-ar/strings.xml")
        assertEquals(en, hi)
        assertEquals(en, ar)
        assertTrue(en.contains("app_title"))
    }
}
