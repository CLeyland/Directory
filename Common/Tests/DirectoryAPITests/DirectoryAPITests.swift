@testable import DirectoryAPI
import XCTest

final class CommonTests: XCTestCase {
    // This is just a small sample text case, a full productin app should
    // include multiple test cased covering both happy & unhappy code paths
    func testExample() throws {
        guard
            let stub = stub
        else {
            XCTAssert(false, "Failed to generate stub data")
            return
        }

        guard
            let rooms = try? Rooms(fromJSON: stub)
        else {
            XCTAssert(false, "Failed to decode stub data")
            return
        }

        XCTAssertEqual(rooms.count, 65)
    }
    
    /// Test API fetch, ideally this should be decoupled from the backend server
    /// so changes/avaliability of eth server do not affec tthe outcome of the test
    func testFetchAPI() throws {
        // Create an expectation
        let expectation = self.expectation(description: "test expectation")
        var testResult = false

        let roomsViewModel = RoomsViewModel()
        roomsViewModel.updateDataHandler = {
            [weak self] in

            guard self != nil else { return }
            
            if roomsViewModel.rooms.count == 65 {
                testResult = true
            }
            
            expectation.fulfill()
        }

        roomsViewModel.filter(occupied: .all)

        // Wait for the expectation to be fulfilled, or time out
        // after x seconds. This is where the test runner will pause.
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(testResult, "unexpected request result")
    }

    let stub = """
     [{"createdAt":"2022-01-24T20:52:50.765Z","isOccupied":false,"maxOccupancy":53539,"id":"1"},{"createdAt":"2022-01-25T14:37:26.128Z","isOccupied":false,"maxOccupancy":34072,"id":"2"},{"createdAt":"2022-01-25T04:00:35.500Z","isOccupied":false,"maxOccupancy":75480,"id":"3"},{"createdAt":"2022-01-25T14:26:15.080Z","isOccupied":false,"maxOccupancy":44832,"id":"4"},{"createdAt":"2022-01-25T02:06:05.225Z","isOccupied":false,"maxOccupancy":1976,"id":"5"},{"createdAt":"2022-01-25T06:59:34.439Z","isOccupied":true,"maxOccupancy":71103,"id":"6"},{"createdAt":"2022-01-25T15:36:51.812Z","isOccupied":true,"maxOccupancy":27837,"id":"7"},{"createdAt":"2022-01-25T12:06:39.942Z","isOccupied":true,"maxOccupancy":2459,"id":"8"},{"createdAt":"2022-01-24T20:21:32.497Z","isOccupied":true,"maxOccupancy":2700,"id":"9"},{"createdAt":"2022-01-25T02:02:31.105Z","isOccupied":true,"maxOccupancy":37701,"id":"10"},{"createdAt":"2022-01-25T03:15:29.232Z","isOccupied":false,"maxOccupancy":66345,"id":"11"},{"createdAt":"2022-01-25T15:34:57.111Z","isOccupied":false,"maxOccupancy":31647,"id":"12"},{"createdAt":"2022-01-25T02:48:18.593Z","isOccupied":false,"maxOccupancy":1907,"id":"13"},{"createdAt":"2022-01-24T20:30:40.274Z","isOccupied":true,"maxOccupancy":48510,"id":"14"},{"createdAt":"2022-01-24T21:01:30.009Z","isOccupied":false,"maxOccupancy":5235,"id":"15"},{"createdAt":"2022-01-24T18:59:52.398Z","isOccupied":false,"maxOccupancy":99744,"id":"16"},{"createdAt":"2022-01-25T08:34:52.601Z","isOccupied":true,"maxOccupancy":30998,"id":"17"},{"createdAt":"2022-01-24T22:56:47.330Z","isOccupied":true,"maxOccupancy":38150,"id":"18"},{"createdAt":"2022-01-25T07:39:16.951Z","isOccupied":false,"maxOccupancy":60911,"id":"19"},{"createdAt":"2022-01-25T11:34:15.495Z","isOccupied":true,"maxOccupancy":81129,"id":"20"},{"createdAt":"2022-01-25T00:34:07.817Z","isOccupied":true,"maxOccupancy":73918,"id":"21"},{"createdAt":"2022-01-25T04:51:39.319Z","isOccupied":true,"maxOccupancy":57235,"id":"22"},{"createdAt":"2022-01-25T03:03:47.053Z","isOccupied":true,"maxOccupancy":57082,"id":"23"},{"createdAt":"2022-01-25T08:37:01.404Z","isOccupied":false,"maxOccupancy":44888,"id":"24"},{"createdAt":"2022-01-25T14:29:04.144Z","isOccupied":false,"maxOccupancy":72860,"id":"25"},{"createdAt":"2022-01-25T11:03:12.111Z","isOccupied":false,"maxOccupancy":68409,"id":"26"},{"createdAt":"2022-01-25T02:10:00.465Z","isOccupied":false,"maxOccupancy":93811,"id":"27"},{"createdAt":"2022-01-25T00:42:26.556Z","isOccupied":true,"maxOccupancy":43728,"id":"28"},{"createdAt":"2022-01-25T10:49:47.460Z","isOccupied":true,"maxOccupancy":83304,"id":"29"},{"createdAt":"2022-01-24T19:26:27.388Z","isOccupied":false,"maxOccupancy":84245,"id":"30"},{"createdAt":"2022-01-25T05:09:03.891Z","isOccupied":false,"maxOccupancy":18024,"id":"31"},{"createdAt":"2022-01-24T20:21:48.372Z","isOccupied":false,"maxOccupancy":95381,"id":"32"},{"createdAt":"2022-01-24T22:15:19.205Z","isOccupied":false,"maxOccupancy":90805,"id":"33"},{"createdAt":"2022-01-25T15:13:39.842Z","isOccupied":false,"maxOccupancy":45193,"id":"34"},{"createdAt":"2022-01-24T19:18:00.145Z","isOccupied":true,"maxOccupancy":12834,"id":"35"},{"createdAt":"2022-01-25T10:32:55.544Z","isOccupied":true,"maxOccupancy":96492,"id":"36"},{"createdAt":"2022-01-24T20:35:24.290Z","isOccupied":false,"maxOccupancy":20082,"id":"37"},{"createdAt":"2022-01-25T05:43:20.679Z","isOccupied":true,"maxOccupancy":48477,"id":"38"},{"createdAt":"2022-01-25T02:25:12.664Z","isOccupied":true,"maxOccupancy":50150,"id":"39"},{"createdAt":"2022-01-25T14:02:00.093Z","isOccupied":false,"maxOccupancy":29677,"id":"40"},{"createdAt":"2022-01-24T18:17:59.263Z","isOccupied":false,"maxOccupancy":24433,"id":"41"},{"createdAt":"2022-01-24T20:39:12.030Z","isOccupied":false,"maxOccupancy":24193,"id":"42"},{"createdAt":"2022-01-25T12:46:01.650Z","isOccupied":false,"maxOccupancy":30893,"id":"43"},{"createdAt":"2022-01-25T07:09:37.321Z","isOccupied":true,"maxOccupancy":51286,"id":"44"},{"createdAt":"2022-01-25T11:17:02.408Z","isOccupied":false,"maxOccupancy":71606,"id":"45"},{"createdAt":"2022-01-24T22:56:05.782Z","isOccupied":true,"maxOccupancy":15537,"id":"46"},{"createdAt":"2022-01-25T10:19:50.328Z","isOccupied":true,"maxOccupancy":55805,"id":"47"},{"createdAt":"2022-01-25T08:02:38.701Z","isOccupied":false,"maxOccupancy":19129,"id":"48"},{"createdAt":"2022-01-25T07:51:50.112Z","isOccupied":true,"maxOccupancy":34431,"id":"49"},{"createdAt":"2022-01-25T09:35:25.705Z","isOccupied":false,"maxOccupancy":45203,"id":"50"},{"createdAt":"2022-01-24T23:52:21.221Z","isOccupied":false,"maxOccupancy":72137,"id":"51"},{"createdAt":"2022-01-25T09:28:27.697Z","isOccupied":false,"maxOccupancy":73373,"id":"52"},{"createdAt":"2022-01-24T22:41:05.740Z","isOccupied":false,"maxOccupancy":52970,"id":"53"},{"createdAt":"2022-01-25T04:55:21.091Z","isOccupied":true,"maxOccupancy":6076,"id":"54"},{"createdAt":"2022-01-25T00:02:16.861Z","isOccupied":true,"maxOccupancy":86442,"id":"55"},{"createdAt":"2022-01-25T04:06:41.358Z","isOccupied":false,"maxOccupancy":33921,"id":"56"},{"createdAt":"2022-01-24T23:04:21.176Z","isOccupied":false,"maxOccupancy":66729,"id":"57"},{"createdAt":"2022-01-25T05:08:38.240Z","isOccupied":false,"maxOccupancy":74729,"id":"58"},{"createdAt":"2022-01-24T18:40:54.130Z","isOccupied":false,"maxOccupancy":17171,"id":"59"},{"createdAt":"2022-01-25T10:37:35.891Z","isOccupied":false,"maxOccupancy":5417,"id":"60"},{"createdAt":"2022-01-25T08:13:02.897Z","isOccupied":false,"maxOccupancy":20038,"id":"61"},{"createdAt":"2022-01-25T01:58:07.607Z","isOccupied":true,"maxOccupancy":65613,"id":"62"},{"createdAt":"2022-01-24T20:25:29.402Z","isOccupied":true,"maxOccupancy":11494,"id":"63"},{"createdAt":"2022-01-25T12:55:03.443Z","isOccupied":true,"maxOccupancy":77236,"id":"64"},{"createdAt":"2022-01-25T10:40:44.723Z","isOccupied":true,"maxOccupancy":72033,"id":"65"}]
    """.data(using: .utf8)
}
