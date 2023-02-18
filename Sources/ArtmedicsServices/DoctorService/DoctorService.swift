import Foundation
import Fetchworking
import ArtmedicsCore
import Combine

public protocol DoctorService: NetworkService {
    func getDoctors() -> AnyPublisher<[Doctor], Error>
    func createDoctor(_ doctor: Doctor) -> AnyPublisher<Doctor, Error>
    func getDoctor(id: UUID) -> AnyPublisher<Doctor, Error>
    func updateDoctor(_ doctor: Doctor) -> AnyPublisher<Doctor, Error>
    func deleteDoctor(id: UUID) -> AnyPublisher<[Doctor], Error>
}
