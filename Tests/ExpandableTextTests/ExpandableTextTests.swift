import XCTest
@testable import ExpandableText

final class ExpandableTextTests: XCTestCase {
    func testLineLimitIsNeverBelowOne() {
        XCTAssertEqual(
            ExpandableTextConfiguration.normalizedLineLimit(0),
            1
        )

        XCTAssertEqual(
            ExpandableTextConfiguration.normalizedLineLimit(-4),
            1
        )
    }

    func testPositiveLineLimitIsPreserved() {
        XCTAssertEqual(
            ExpandableTextConfiguration.normalizedLineLimit(3),
            3
        )
    }

    func testDetectsTruncationWhenFullTextIsTaller() {
        XCTAssertTrue(
            TruncationDetector.isTruncated(
                fullHeight: 96,
                collapsedHeight: 54
            )
        )
    }

    func testDoesNotReportTruncationForEqualHeights() {
        XCTAssertFalse(
            TruncationDetector.isTruncated(
                fullHeight: 54,
                collapsedHeight: 54
            )
        )
    }

    func testSmallMeasurementDifferenceIsIgnored() {
        XCTAssertFalse(
            TruncationDetector.isTruncated(
                fullHeight: 54.3,
                collapsedHeight: 54,
                tolerance: 0.5
            )
        )
    }

    func testInvalidMeasurementsDoNotReportTruncation() {
        XCTAssertFalse(
            TruncationDetector.isTruncated(
                fullHeight: .infinity,
                collapsedHeight: 40
            )
        )

        XCTAssertFalse(
            TruncationDetector.isTruncated(
                fullHeight: 0,
                collapsedHeight: 0
            )
        )
    }
}
