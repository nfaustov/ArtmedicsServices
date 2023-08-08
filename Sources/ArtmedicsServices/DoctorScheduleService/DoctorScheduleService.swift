import Foundation
import Combine
import ArtmedicsCore
import Fetchworking

public protocol DoctorScheduleService: NetworkService {
    func create(_ doctorSchedule: DoctorSchedule) -> AnyPublisher<DoctorSchedule, Error>
    func getSchedulesByDate(_ date: Date) -> AnyPublisher<[DoctorSchedule], Error>
    func getSchedulesByDoctor(_ doctorID: UUID) -> AnyPublisher<[DoctorSchedule], Error>
    func updateSchedule(_ schedule: DoctorSchedule) -> AnyPublisher<Bool, Error>
    func deleteSchedule(_ scheduleID: UUID) -> AnyPublisher<Bool, Error>
}
