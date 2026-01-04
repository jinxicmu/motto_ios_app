import WidgetKit
import SwiftUI

// NOTE: You must create a Widget Extension Target in Xcode and add this file to that target.
// You also need to ensure DataService and MottoModel are available to the Widget Target (Target Membership).

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), motto: MottoItem(id: 0, date_index: 0, word_cn: "Motto", word_en: "Motto", sentence_cn: "Loading...", sentence_en: "Loading...", author: ""))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), motto: DataService.shared.getDailyMotto() ?? MottoItem(id: 1, date_index: 1, word_cn: "测试", word_en: "Test", sentence_cn: "Test Sentence", sentence_en: "Test Sentence", author: "Author"))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Refresh at midnight
        let currentDate = Date()
        let calendar = Calendar.current
        guard let nextMidnight = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: currentDate.addingTimeInterval(24*60*60)) else {
            return 
        }

        let motto = DataService.shared.getDailyMotto() ?? MottoItem(id: 1, date_index: 1, word_cn: "恒", word_en: "Perserverance", sentence_cn: "Placeholder", sentence_en: "Placeholder", author: "Laozi")
        
        let entry = SimpleEntry(date: currentDate, motto: motto)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .after(nextMidnight))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let motto: MottoItem
}

struct MottoWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
            
            VStack {
                Text(entry.motto.word_cn)
                    .font(.system(size: family == .systemSmall ? 30 : 50, weight: .light, design: .serif))
                
                if family != .systemSmall {
                    Text(entry.motto.sentence_en)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }
        }
    }
}

// @main  <-- Uncomment this if this is the only widget file in the target
struct MottoWidget: Widget {
    let kind: String = "MottoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MottoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Motto Daily")
        .description("Your daily dose of mindfulness.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct MottoWidget_Previews: PreviewProvider {
    static var previews: some View {
        MottoWidgetEntryView(entry: SimpleEntry(date: Date(), motto: MottoItem(id: 1, date_index: 1, word_cn: "恒", word_en: "Perseverance", sentence_cn: "...", sentence_en: "...", author: "Laozi")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
