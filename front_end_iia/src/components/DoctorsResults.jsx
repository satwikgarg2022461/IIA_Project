import { ConfigProvider, theme, Card } from "antd"; // Ant Design components
import DoctorLogo from "../assets/doctor_svg.png";

const DoctorResults = () => {
    const dummyDoctors = [
        { id: 1, name: "Dr. John Doe", specialty: "Cardiologist", hospital: "General Hospital" },
        { id: 2, name: "Dr. Jane Smith", specialty: "Dermatologist", hospital: "City Clinic" },
    ];

    const appointments = [
        { id: 1, patient: "Alice Johnson", date: "2024-11-25", doctor: "Dr. John Doe" },
        { id: 2, patient: "Bob Brown", date: "2024-11-26", doctor: "Dr. Jane Smith" },
    ];

    return (
        <ConfigProvider
            theme={{
                algorithm: theme.darkAlgorithm,
                token: {
                    colorBgContainer: "#e2e8f0", // Tailwind gray-100
                    colorText: "#1e293b", // Tailwind gray-800
                    colorBorder: "#94a3b8", // Tailwind gray-400
                },
            }}
        >
            <div className="min-h-screen flex flex-col items-center justify-between bg-gray-100">
                {/* Header */}
                <header className="w-full py-4 bg-blue-700 text-white flex justify-between items-center px-6">
                    <h1 className="text-2xl font-semibold">Welcome to our Health Compass</h1>
                    <img src={DoctorLogo} alt="Doctors" className="h-10 w-10" />
                </header>

                {/* Results Section */}
                <main className="w-full flex flex-col items-center mt-12 px-4">
                    {/* Doctors Section */}
                    <section className="w-full max-w-4xl bg-white rounded-lg shadow-md p-6 mb-8">
                        <h2 className="text-xl font-semibold text-gray-800 mb-4">Best Matching Doctors</h2>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                            {dummyDoctors.map((doctor) => (
                                <Card key={doctor.id} className="shadow-sm">
                                    <h3 className="text-lg font-bold">{doctor.name}</h3>
                                    <p className="text-sm text-gray-700">{doctor.specialty}</p>
                                    <p className="text-sm text-gray-500">{doctor.hospital}</p>
                                </Card>
                            ))}
                        </div>
                    </section>

                    {/* Appointments Section */}
                    <section className="w-full max-w-4xl bg-white rounded-lg shadow-md p-6">
                        <h2 className="text-xl font-semibold text-gray-800 mb-4">Upcoming Appointments</h2>
                        <ul className="space-y-4">
                            {appointments.map((appointment) => (
                                <li
                                    key={appointment.id}
                                    className="p-4 border border-gray-200 rounded-lg shadow-sm"
                                >
                                    <p className="text-sm font-medium">
                                        <strong>Patient:</strong> {appointment.patient}
                                    </p>
                                    <p className="text-sm font-medium">
                                        <strong>Date:</strong> {appointment.date}
                                    </p>
                                    <p className="text-sm font-medium">
                                        <strong>Doctor:</strong> {appointment.doctor}
                                    </p>
                                </li>
                            ))}
                        </ul>
                    </section>
                </main>

                {/* Footer */}
                <footer className="w-full py-4 bg-blue-700 text-white flex justify-between px-6 text-sm">
                    <span className="hover:underline cursor-pointer">Terms & Conditions</span>
                    <span className="hover:underline cursor-pointer">Help/Contact</span>
                </footer>
            </div>
        </ConfigProvider>
    );
};

export default DoctorResults;
