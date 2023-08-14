import Foundation
import Fetchworking
import Combine
import ArtmedicsCore

final class DoctorScheduleServiceClient: DoctorScheduleService {
    let networkController: any Fetchworking

    init(networkController: any Fetchworking = NetworkController()) {
        self.networkController = networkController
    }
    
    func create(_ doctorSchedule: DoctorSchedule) -> AnyPublisher<DoctorSchedule, Error> {
        networkController.request(method: .post, endpoint: .create(doctorSchedule))
    }

    func getSchedulesByDate(_ date: Date) -> AnyPublisher<[DoctorSchedule], Error> {
        networkController.request(method: .get, endpoint: .getByDate(date))
    }

    func getSchedulesByDoctor(_ doctorID: UUID) -> AnyPublisher<[DoctorSchedule], Error> {
        networkController.request(method: .get, endpoint: .getByDoctor(doctorID))
    }

    func updateSchedule(_ schedule: DoctorSchedule) -> AnyPublisher<Bool, Error> {
        networkController.request(method: .put, endpoint: .update(schedule))
    }

    func deleteSchedule(_ scheduleID: UUID) -> AnyPublisher<Bool, Error> {
        networkController.request(method: .delete, endpoint: .delete(scheduleID))
    }
}

// MARK: - Endpoints

private extension Endpoint {
    static func create(_ doctorSchedule: DoctorSchedule) -> Self {
        Endpoint(path: "/schedules", body: makeJSON(doctorSchedule))
    }

    static func getByDate(_ date: Date) -> Self {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 10_800)
        let query = URLQueryItem(name: "date", value: "\(formatter.string(from: date))")
        
        return Endpoint(path: "/schedules", queryItems: [query])
    }

    static func getByDoctor(_ doctorID: UUID) -> Self {
        Endpoint(path: "/schedules/\(doctorID.uuidString)")
    }

    static func update(_ schedule: DoctorSchedule) -> Self {
        Endpoint(path: "/schedules/\(schedule.id.uuidString)", body: makeJSON(schedule))
    }

    static func delete(_ scheduleID: UUID) -> Self {
        Endpoint(path: "/schedules/\(scheduleID.uuidString)")
    }
}

// MARK: - DependencyKey

private struct DoctorScheduleServiceKey: DependencyKey {
    static var currentValue: DoctorScheduleService = DoctorScheduleServiceClient()
}

public extension ArtmedicsServices {
    var doctorScheduleService: DoctorScheduleService {
        get { Self[DoctorScheduleServiceKey.self] }
        set { Self[DoctorScheduleServiceKey.self] = newValue }
    }
}
