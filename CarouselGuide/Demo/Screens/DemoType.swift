import SwiftUI

/// catalog entry for each root-menu demo.
enum DemoType: String, CaseIterable, Identifiable, Hashable {
    
    case horizontal
    case vertical
    case horizontalInfinite
    case verticalInfinite
    case stackedVertical
    case stackedHorizontal

    var id: String { rawValue }

    var title: String {
        switch self {
            case .horizontal:           "Finite Horizontal"
            case .vertical:             "Finite Vertical"
            case .horizontalInfinite:   "Infinite Horizontal"
            case .verticalInfinite:     "Infinite Vertical"
            case .stackedVertical:      "3D Infinite Vertical"
            case .stackedHorizontal:    "3D Infinite Horizontal"
        }
    }

    var subtitle: String {
        switch self {
            case .horizontal:           "Snapping pages that scroll left and right"
            case .vertical:             "Snapping pages that scroll up and down"
            case .horizontalInfinite:   "Endless Horizontal paging without a hard edge"
            case .verticalInfinite:     "Endless Vertical paging without a hard edge"
            case .stackedVertical:      "Cards on a Vertical 3D circle — top arcs behind to become bottom"
            case .stackedHorizontal:    "Cards on a Horizontal 3D circle — left arcs behind to right"
        }
    }

    var systemImage: String {
        switch self {
            case .horizontal:   "rectangle.split.2x1"
            case .vertical:     "rectangle.split.1x2"
            case .horizontalInfinite, .verticalInfinite:    "infinity.circle"
            case .stackedVertical, .stackedHorizontal:      "square.stack.3d.up"
        }
    }

    /// applied to the menu glyph
    var systemImageRotation: Angle {
        switch self {
            case .verticalInfinite, .stackedHorizontal: .degrees(90)
            default: .zero
        }
    }

    /// stacked circle demos (not `CarouselView` / UIScrollView).
    var isStacked: Bool { self == .stackedVertical || self == .stackedHorizontal }

    var configuration: CarouselConfiguration {
        switch self {
            case .horizontal:
                CarouselConfiguration(axis: .horizontal, isInfinite: false)
            case .vertical:
                CarouselConfiguration(
                    axis: .vertical,
                    isInfinite: false,
                    contentInsets: EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20)
                )
            case .horizontalInfinite:
                CarouselConfiguration(axis: .horizontal, isInfinite: true)
            case .verticalInfinite:
                CarouselConfiguration(
                    axis: .vertical,
                    isInfinite: true,
                    contentInsets: EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20)
                )
            case .stackedVertical:
                CarouselConfiguration(axis: .vertical, isInfinite: true)
            case .stackedHorizontal:
                CarouselConfiguration(axis: .horizontal, isInfinite: true)
        }
    }

    var items: [CarouselItem] { SampleData.cards }

    var modeCaption: String {
        switch self {
            case .stackedHorizontal:
                return "Circular 3D carousel. The leading card arcs behind the center and emerges on the trailing side."
            case .stackedVertical:
                return "Circular 3D carousel. The top card moves behind the center and emerges as the bottom."
            case .horizontal, .vertical, .horizontalInfinite, .verticalInfinite:
                return configuration.isInfinite
                    ? "Auto-advances forever. Dragging pauses playback, then it resumes after a short delay."
                    : "Auto-advances through the set and wraps to the start. Dragging pauses playback, then it resumes."
        }
    }

    func modeCaption(autoScrollEnabled: Bool) -> String {
        if isStacked {
            if autoScrollEnabled {
                return axis == .horizontal
                    ? "Circular 3D Horizontal carousel — the left card travels behind and becomes the right. Auto-advances forever. Dragging pauses playback, then it resumes after a short delay."
                    : "Circular 3D Vertical carousel — the top card travels behind and becomes the bottom. Auto-advances forever. Dragging pauses playback, then it resumes after a short delay."
            }
            return modeCaption
        }
        return autoScrollEnabled
            ? modeCaption
            : "Manual scroll only. Swipe forward and backwards in order to switch through the pages."
    }

    var axis: CarouselAxis { configuration.axis }

    var footerLabel: String {
        if isStacked {
            return axis == .horizontal ? "3D infinite · Horizontal" : "3D infinite · Vertical"
        }
        return configuration.isInfinite ? "Infinite loop" : "Finite range"
    }

    var footerSystemImage: String {
        if isStacked { return "square.stack.3d.up" }
        return configuration.isInfinite ? "infinity" : "arrow.left.arrow.right"
    }

    /// footer glyph rotation — vertical demos read as up/down.
    var footerSystemImageRotation: Angle {
        switch self {
            case .horizontal:           .zero
            case .vertical:             .degrees(90)
            case .horizontalInfinite:   .zero
            case .verticalInfinite:     .degrees(90)
            case .stackedVertical:      .zero
            case .stackedHorizontal:    .degrees(90)
        }
    }
}
