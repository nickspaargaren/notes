import SwiftUI
import SwiftData
import Charts

struct StatsView: View {
    @Query private var items: [Time]
    
    private var groupedItems: [(key: String, count: Int)] {
        let grouped = Dictionary(grouping: items, by: { $0.gamertag })
        return grouped.map { (key: $0.key, count: $0.value.count) }.sorted(by: { $0.count > $1.count })
    }
    
    var body: some View {
            Chart {
                ForEach(groupedItems, id: \.key) { key, count in
                    BarMark(
                        x: .value("Gamertag", key),
                        y: .value("Total Count", count)
                    )
                }
            }

    }
}

#if DEBUG
struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .modelContainer(for: Time.self, inMemory: true)
    }
}
#endif
