import SwiftUI

enum SampleData {
    
    static let cards: [CarouselItem] = [
        .solid(
            id: "1",
            hex: "#264653",
            symbolName: "moon.stars",
            color: Color(red: 0x26 / 255, green: 0x46 / 255, blue: 0x53 / 255)
        ),
        .solid(
            id: "2",
            hex: "#287271",
            symbolName: "airplane.departure",
            color: Color(red: 0x28 / 255, green: 0x72 / 255, blue: 0x71 / 255)
        ),
        .solid(
            id: "3",
            hex: "#2a9d8f",
            symbolName: "sparkles",
            color: Color(red: 0x2a / 255, green: 0x9d / 255, blue: 0x8f / 255)
        ),
        .solid(
            id: "4",
            hex: "#e9c46a",
            symbolName: "sun.haze.fill",
            color: Color(red: 0xe9 / 255, green: 0xc4 / 255, blue: 0x6a / 255)
        ),
        .solid(
            id: "5",
            hex: "#f4a261",
            symbolName: "apple.logo",
            color: Color(red: 0xf4 / 255, green: 0xa2 / 255, blue: 0x61 / 255)
        ),
        .solid(
            id: "6",
            hex: "#e76f51",
            symbolName: "flame",
            color: Color(red: 0xe7 / 255, green: 0x6f / 255, blue: 0x51 / 255)
        )
    ]
}

private extension CarouselItem {
    
    static func solid(id: String, hex: String, symbolName: String, color: Color) -> CarouselItem {
        CarouselItem(
            id: id,
            title: "Item number \(id)",
            subtitle: "Card color \(hex)",
            symbolName: symbolName,
            gradientColors: [color, color]
        )
    }
}
