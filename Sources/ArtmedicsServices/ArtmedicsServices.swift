import Fetchworking

public protocol NetworkServiceContainer: ServiceContainer {
    var doctorService: DoctorService { get }
}

public final class ArtmedicsServices: NetworkServiceContainer {
    public let host: any HostType

    public init(host: any HostType = Host.local) {
        self.host = host
    }

    public lazy var doctorService: DoctorService = DoctorServiceClient(host: host)
    public lazy var doctorScheduleService: DoctorScheduleService = DoctorScheduleServiceClient(host: host)
}

public enum Host: String, HostType {
    case local = "http://127.0.0.1:8080"
    case test
    case production = "https://artmedics.ru/api/v0"
}

