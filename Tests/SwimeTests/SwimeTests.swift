import Testing
import Foundation
@testable import Swime

struct SwimeTests {

    @Test func testReadBytes() async throws {
        let str = "hello"
        let data = try #require(str.data(using: .utf8))
        let swime = Swime(data: data)
        let bytes = swime.readBytes(count: 4)

        #expect(bytes.count == 4)

        let endIndex = str.index(str.startIndex, offsetBy: 4)
        let substr = str[..<endIndex]
        let expectation = [UInt8](substr.utf8)

        #expect(bytes == expectation)
    }

    @Test func testMimeTypeData() async throws {
        for ext in extensions {
            let data = loadFileData(path: "fixtures/fixture.\(ext)")
            let mimeType = Swime.mimeType(data: data)

            if let mime = mimeTypeByExtension[ext] {
                #expect(mimeType?.mime == mime)
            } else {
                #expect(mimeType?.ext == ext)
            }
        }

        let data = loadFileData(path: "fixtures/fake.png")
        let mimeType = Swime.mimeType(data: data)
        #expect(mimeType == nil)
    }

    @Test func testMimeTypeBytes() async throws {
        var bytes: [UInt8] = [255, 216, 255]
        var mimeType = Swime.mimeType(bytes: bytes)

        #expect(mimeType?.mime == "image/jpeg")

        bytes = [55, 122, 188, 175, 39, 28]
        mimeType = Swime.mimeType(bytes: bytes)

        #expect(mimeType?.mime == "application/x-7z-compressed")

        bytes = [
            0x3f, 0x47, 0x00, 0x00, 0x6b, 0x46, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x04, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x90, 0x01, 0x00, 0x00,
            0x00, 0x00, 0x4c, 0x50, 0x27, 0x00, 0x00, 0x80, 0x0b, 0x00, 0x00, 0x00, 0x28, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x00, 0x00, 0x9f, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfa, 0x98, 0x03, 0x03,
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
            0x00, 0x00, 0x12, 0x00, 0x4f, 0x00, 0x70, 0x00, 0x65, 0x00, 0x6e, 0x00, 0x20, 0x00, 0x53, 0x00
        ]

        mimeType = Swime.mimeType(bytes: bytes)
        #expect(mimeType?.mime == "application/vnd.ms-fontobject")
    }

    @Test func testMimeTypeBytesTypeProperty() async throws {
        var data: Data = loadFileData(path: "fixtures/fixture.jpg")
        var mimeType = Swime.mimeType(data: data)

        #expect(mimeType?.type == .jpg)

        data = loadFileData(path: "fixtures/fixture.pdf")
        mimeType = Swime.mimeType(data: data)

        #expect(mimeType?.type == .pdf)

        data = loadFileData(path: "fixtures/fixture.png")
        mimeType = Swime.mimeType(data: data)

        #expect(mimeType?.type != .jpg)
    }
}
