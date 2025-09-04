# Phase 3: Religious & Spiritual Life Management (Week 3)

## Objective
Develop comprehensive Islamic spiritual life tracking with prayer monitoring, Qadā' (missed prayers) management, and spiritual goal setting to maintain religious consistency.

## Enhanced Database Design

### Prayer & Spiritual Schema

#### `dailyPrayersBox` - Daily Prayer Tracking
```dart
@HiveType(typeId: 10)
class DailyPrayers {
  @HiveField(0) String id;
  @HiveField(1) DateTime date; // Hijri and Gregorian
  @HiveField(2) String hijriDate; // Formatted hijri date
  @HiveField(3) PrayerStatus fajrStatus;
  @HiveField(4) PrayerStatus dhuhrStatus;
  @HiveField(5) PrayerStatus asrStatus;
  @HiveField(6) PrayerStatus maghribStatus;
  @HiveField(7) PrayerStatus ishaStatus;
  @HiveField(8) int totalPrayed; // Count for the day
  @HiveField(9) Duration totalPrayerTime; // Time spent in prayer
  @HiveField(10) List<String> notes; // Daily spiritual notes
  @HiveField(11) int spiritualMoodRating; // 1-5 scale
}

@HiveType(typeId: 11)
enum PrayerStatus {
  @HiveField(0) onTime,     // Prayed within time
  @HiveField(1) late,       // Prayed but after time
  @HiveField(2) makeup,     // Made up later
  @HiveField(3) missed,     // Not prayed
  @HiveField(4) traveling,  // Traveling exemption
  @HiveField(5) sick,       // Illness exemption
}
```

#### `qadaPrayersBox` - Missed Prayer Management
```dart
@HiveType(typeId: 12)
class QadaTracker {
  @HiveField(0) String id;
  @HiveField(1) PrayerType prayerType;
  @HiveField(2) int totalMissed;
  @HiveField(3) int totalMadeUp;
  @HiveField(4) int currentDebt; // remaining missed prayers
  @HiveField(5) int dailyTarget; // prayers to make up daily
  @HiveField(6) DateTime lastUpdated;
  @HiveField(7) List<QadaSession> recentSessions;
  @HiveField(8) QadaGoal? activeGoal;
}

@HiveType(typeId: 13)
class QadaSession {
  @HiveField(0) String id;
  @HiveField(1) DateTime date;
  @HiveField(2) PrayerType prayerType;
  @HiveField(3) int count; // How many made up in this session
  @HiveField(4) Duration duration;
  @HiveField(5) String? notes;
  @HiveField(6) int spiritualFocus; // 1-5 concentration level
}

@HiveType(typeId: 14)
class QadaGoal {
  @HiveField(0) String id;
  @HiveField(1) String title;
  @HiveField(2) PrayerType? specificPrayer; // null for all prayers
  @HiveField(3) int targetCount;
  @HiveField(4) DateTime startDate;
  @HiveField(5) DateTime targetDate;
  @HiveField(6) int currentProgress;
  @HiveField(7) List<String> motivationalNotes;
}
```

#### `dhikrSessionsBox` - Remembrance Tracking
```dart
@HiveType(typeId: 15)
class DhikrSession {
  @HiveField(0) String id;
  @HiveField(1) DateTime date;
  @HiveField(2) DhikrType type; // Tasbih, Istighfar, Quran, etc.
  @HiveField(3) String dhikrText; // The actual dhikr
  @HiveField(4) int targetCount;
  @HiveField(5) int actualCount;
  @HiveField(6) Duration duration;
  @HiveField(7) String? notes;
  @HiveField(8) int focusRating; // 1-5 concentration level
  @HiveField(9) bool isCompleted;
}

@HiveType(typeId: 16)
enum DhikrType {
  @HiveField(0) subhanAllah,
  @HiveField(1) alhamdulillah,
  @HiveField(2) allahuAkbar,
  @HiveField(3) laIlahaIllAllah,
  @HiveField(4) istighfar,
  @HiveField(5) quranRecitation,
  @HiveField(6) duaa,
  @HiveField(7) custom,
}
```

#### `islamicCalendarBox` - Special Days & Events
```dart
@HiveType(typeId: 17)
class IslamicEvent {
  @HiveField(0) String id;
  @HiveField(1) String name;
  @HiveField(2) String hijriDate;
  @HiveField(3) DateTime gregorianDate;
  @HiveField(4) EventType type; // Eid, Ramadan, Hajj, etc.
  @HiveField(5) String description;
  @HiveField(6) List<String> recommendedActions;
  @HiveField(7) bool hasSpecialPrayers;
  @HiveField(8) bool isFastingDay;
  @HiveField(9) int priority; // 1-5 importance level
}
```

#### `spiritualGoalsBox` - Religious Goals & Habits
```dart
@HiveType(typeId: 18)
class SpiritualGoal {
  @HiveField(0) String id;
  @HiveField(1) String title;
  @HiveField(2) String description;
  @HiveField(3) GoalType type; // Daily, Weekly, Monthly, Yearly
  @HiveField(4) SpiritualCategory category;
  @HiveField(5) DateTime startDate;
  @HiveField(6) DateTime? endDate;
  @HiveField(7) int targetValue; // e.g., 100 dhikr, 5 prayers
  @HiveField(8) int currentProgress;
  @HiveField(9) List<String> milestones;
  @HiveField(10) bool isActive;
  @HiveField(11) String? reward; // Personal reward for completion
}

@HiveType(typeId: 19)
enum SpiritualCategory {
  @HiveField(0) prayer,
  @HiveField(1) quran,
  @HiveField(2) dhikr,
  @HiveField(3) charity,
  @HiveField(4) fasting,
  @HiveField(5) knowledge,
  @HiveField(6) character,
}
```

## Daily Tasks & Implementation

### Day 1: Prayer Tracking Foundation
- [ ] Create prayer tracking data models and adapters
- [ ] Implement prayer time calculation (using location)
- [ ] Set up daily prayer status tracking
- [ ] Create prayer notification system
- [ ] Build basic prayer logging interface

### Day 2: Advanced Prayer Features
- [ ] Implement prayer time adjustments for location
- [ ] Add congregation vs individual prayer tracking
- [ ] Create prayer statistics and streaks
- [ ] Build missed prayer identification system
- [ ] Add travel mode for prayer adjustments

### Day 3: Qadā' Prayer Management
- [ ] Create Qadā' debt calculation system
- [ ] Implement make-up prayer tracking
- [ ] Build Qadā' goal setting interface
- [ ] Create progress visualization for missed prayers
- [ ] Add motivational reminders for Qadā'

### Day 4: Dhikr & Remembrance
- [ ] Implement digital tasbih counter
- [ ] Create dhikr session tracking
- [ ] Add pre-defined dhikr collections
- [ ] Build custom dhikr creation
- [ ] Implement dhikr reminders and goals

### Day 5: Islamic Calendar Integration
- [ ] Integrate Hijri calendar system
- [ ] Add Islamic events and important dates
- [ ] Create Ramadan and Hajj special modes
- [ ] Implement special occasion reminders
- [ ] Build event-based goal setting

### Day 6: Spiritual Analytics & Insights
- [ ] Create prayer consistency reports
- [ ] Build Qadā' progress analytics
- [ ] Implement spiritual growth tracking
- [ ] Add monthly spiritual summaries
- [ ] Create streak and milestone celebrations

### Day 7: Polish & Integration
- [ ] Integrate with task management for Islamic tasks
- [ ] Polish UI with Islamic aesthetic elements
- [ ] Add Arabic/Islamic typography support
- [ ] Optimize for daily spiritual routine
- [ ] Test religious calculation accuracy

## Key Features Delivered

### Prayer Management
1. **Daily Prayer Tracking**
   - 5 daily prayers with status tracking
   - Prayer time notifications with Adhan
   - Congregation vs individual prayer logging
   - Travel and sick day accommodations
   - Prayer streak tracking and statistics

2. **Qadā' (Missed Prayer) System**
   - Automatic missed prayer calculation
   - Make-up prayer goal setting
   - Progress tracking with visual indicators
   - Motivational reminders and milestones
   - Historical Qadā' debt management

### Spiritual Practices
1. **Dhikr & Remembrance**
   - Digital tasbih with haptic feedback
   - Customizable dhikr collections
   - Session tracking with time and count
   - Daily dhikr goals and reminders
   - Focus and concentration rating

2. **Islamic Calendar**
   - Hijri date display and tracking
   - Important Islamic events reminder
   - Ramadan and Hajj special features
   - Moon phase tracking for dates
   - Community event scheduling

### Spiritual Growth
1. **Goal Setting & Tracking**
   - Religious habit formation
   - Spiritual milestone tracking
   - Character improvement goals
   - Knowledge acquisition targets
   - Charity and good deed logging

## Personal Spiritual Management Features
- **Mood & Spirituality Correlation**: Track how spiritual practices affect daily mood
- **Qibla Direction**: Built-in compass for prayer direction
- **Islamic Quotes**: Daily inspirational verses and hadith
- **Ramadan Mode**: Special tracking for fasting, iftar, suhoor
- **Local Mosque Integration**: Find nearby mosques and prayer times

## Success Metrics
- [ ] Can accurately track daily prayers for 30+ days
- [ ] Qadā' calculations are mathematically correct
- [ ] Prayer time notifications are accurate to location
- [ ] Dhikr counter supports 1000+ count sessions
- [ ] Islamic calendar dates align with official sources

## Integration with Other Phases
- Link spiritual goals to daily task management
- Track time spent in religious activities
- Financial tracking for charity (Zakat, Sadaqah)
- Schedule spiritual activities in calendar

## Cultural Considerations
- **Language Support**: Arabic text support for prayers and dhikr
- **Regional Variations**: Different calculation methods for prayer times
- **Accessibility**: Voice-guided dhikr for visually impaired
- **Privacy**: Secure storage of personal spiritual data

## Phase 3 Completion Checklist
- [ ] All prayer tracking features functional
- [ ] Qadā' management system complete
- [ ] Dhikr and remembrance tools working
- [ ] Islamic calendar integrated
- [ ] Spiritual analytics and insights ready
- [ ] Religious calculation accuracy verified
- [ ] UI culturally appropriate and respectful