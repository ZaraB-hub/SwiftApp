import Foundation

func anxietyLabel(for value: Int) -> String {
	switch value {
	case 1: return "Barely bothered"
	case 2: return "A little uneasy"
	case 3: return "Somewhat nervous"
	case 4: return "Noticeably anxious"
	case 5: return "Moderately stressed"
	case 6: return "Quite anxious"
	case 7: return "Very anxious"
	case 8: return "Really struggling"
	case 9: return "Extremely overwhelmed"
	case 10: return "Cannot function right now"
	default: return ""
	}
}
