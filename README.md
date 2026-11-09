# SwiftUI Carousels Guide

Sample app that demonstrates **six** iOS carousel patterns in one place:

1. Finite horizontal (SwiftUI)  
2. Finite vertical (SwiftUI)  
3. Infinite horizontal (UIKit pager)  
4. Infinite vertical (UIKit pager)  
5. 3D infinite vertical (circle stack)  
6. 3D infinite horizontal (circle stack)  

Each demo supports **Auto** and **Manual** modes with pause-on-user-drag.

small taste from within the app:

<img width="400" height="869" alt="nkCarousels" src="https://github.com/user-attachments/assets/ee4211ae-4bae-476b-af14-4992f15ba010" />

**Medium Article:**  https://medium.com/@noamkurtzer/swiftui-carousels-74debf4f62ef

**Repo:** https://github.com/NoamKu95/SwiftUI-Carousels

**Requires:** Xcode 15+, iOS 17 SDK

## Run

1. Open `CarouselGuide.xcodeproj`
2. Pick an iPhone simulator or your real device
3. Run (`⌘R`)

No SPM / CocoaPods dependencies.

## Architecture

```
CarouselGuide/
├── App/                         # @main entry
├── Carousel/                    
│   ├── CarouselAxis.swift
│   ├── CarouselConfiguration.swift
│   ├── AutoScrollController.swift
│   ├── CarouselView.swift       # finite + infinite facade
│   ├── FiniteCarouselLayout.swift
│   ├── PageIndicatorView.swift
│   ├── Infinite/
│   │   ├── InfinitePagingScrollView.swift
│   │   └── InfinitePagingController.swift
│   └── Stack/
│       ├── StackCarouselMetrics.swift
│       └── StackedInfiniteCarouselView.swift
├── Demo/                        # sample screens + data only
│   ├── Models/
│   ├── Components/
│   └── Screens/
├── SampleData.swift
└── Resources/
```

| Concern | Type | Notes |
|---------|------|--------|
| Finite paging | `CarouselView` → `FiniteCarouselLayout` | SwiftUI `scrollTargetBehavior` |
| Infinite paging | `CarouselView` → `InfinitePagingScrollView` | Triple-buffer + `setContentOffset` |
| 3-up circle | `StackedInfiniteCarouselView` | Continuous ring `progress` |
| Auto-scroll | `AutoScrollController` | Shared timer + resume delay |
| Layout math | `StackCarouselMetrics` | Axis-aware sizing helpers |

### Drop-in usage

`CarouselView` takes items, a `CarouselConfiguration`, selection, and a card builder. Axis / infinite / auto-scroll / interval / insets all live on the configuration (the demo builds it from `DemoKind` + the Auto/Manual controls):

```swift
var configuration = CarouselConfiguration(
    axis: .horizontal,
    isInfinite: true,
    autoScrollEnabled: true,
    autoScrollInterval: 3
)
CarouselView(
    items: destinations,
    configuration: configuration,
    selection: $selectedID
) { item in
    SampleCardView(item: item, style: .featured)
        .padding(.bottom, 28)
}
```

The 3D stack is a separate API — it needs axis, aspect ratio, and explicit auto-scroll hooks:

```swift
StackedInfiniteCarouselView(
    items: cardDesigns,
    currentIndex: $index,
    axis: .vertical,
    cardAspectRatio: StackCarouselMetrics.creditCardAspectRatio,
    autoAdvanceTick: autoScroll.tick,
    autoScrollEnabled: true,
    onUserDrag: { autoScroll.pauseForUserInteraction() }
) { item in
    SampleCardView(item: item, style: .featured)
}
.frame(height: StackCarouselMetrics.stackExtent(forCardCrossAxis: width))
```

## Demo map

| Demo | Axis | Looping |
|------|------|---------|
| Horizontal Carousel | H | Finite |
| Vertical Carousel | V | Finite |
| Infinite Horizontal | H | Seamless |
| Infinite Vertical | V | Seamless |
| 3D Infinite Vertical | V circle | Infinite |
| 3D Infinite Horizontal | H circle | Infinite |


## License

Sample code for educational use.
