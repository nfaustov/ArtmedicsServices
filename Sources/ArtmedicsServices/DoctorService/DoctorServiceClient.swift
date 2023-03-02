import Foundation
import Combine
import ArtmedicsCore
import Fetchworking

final class DoctorServiceClient: DoctorService {
    let networkController: any Fetchworking

    init(networkController: any Fetchworking = NetworkController()) {
        self.networkController = networkController
    }

    func getDoctors() -> AnyPublisher<[Doctor], Error> {
        networkController.request(method: .get, endpoint: .doctors)
    }

    func createDoctor(_ doctor: Doctor) -> AnyPublisher<Doctor, Error> {
        networkController.request(method: .post, endpoint: .create(doctor))
    }

    func getDoctor(id: UUID) -> AnyPublisher<Doctor, Error> {
        networkController.request(method: .get, endpoint: .doctor(id))
    }

    func updateDoctor(_ doctor: Doctor) -> AnyPublisher<Doctor, Error> {
        networkController.request(method: .put, endpoint: .create(doctor))
    }

    func deleteDoctor(id: UUID) -> AnyPublisher<[Doctor], Error> {
        networkController.request(method: .delete, endpoint: .doctor(id))
    }
}

// MARK: - Endpoints

private extension Endpoint {
    static var doctors: Self {
        Endpoint(path: "/doctors")
    }

    static func create(_ doctor: Doctor) -> Self {
        Endpoint(path: "/doctors", body: makeJSON(doctor))
    }

    static func doctor(_ doctorID: UUID) -> Self {
        Endpoint(path: "/doctors/\(doctorID.uuidString)")
    }

    static func update(_ doctor: Doctor) -> Self {
        Endpoint(path: "/doctors/\(doctor.id.uuidString)", body: makeJSON(doctor))
    }
}

// MARK: - DependencyKey

struct DoctorServiceKey: DependencyKey {
    static var currentValue: DoctorService = DoctorServiceClient()
}

extension ArtmedicsServices {
    private var doctorService: DoctorService {
        get { Self[DoctorServiceKey.self] }
        set { Self[DoctorServiceKey.self] = newValue }
    }
}
