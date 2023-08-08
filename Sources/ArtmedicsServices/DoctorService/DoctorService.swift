import Foundation
import Fetchworking
import ArtmedicsCore
import Combine

public protocol DoctorService: NetworkService {
    func getDoctors() -> AnyPublisher<[Doctor], Error>
    func createDoctor(_ doctor: Doctor) -> AnyPublisher<Bool, Error>
    func getDoctor(id: UUID) -> AnyPublisher<Doctor, Error>
    func updateDoctor(_ doctor: Doctor) -> AnyPublisher<Bool, Error>
    func uploadPhoto(_ imageData: Data, for doctor: Doctor) -> AnyPublisher<Bool, Error>
    func deleteDoctor(id: UUID) -> AnyPublisher<Bool, Error>
}
